/**
 * utils.h - PageRank 并行算法公共工具库
 *
 * 包含：
 *   - 图的 CSR (Compressed Sparse Row) 格式表示
 *   - 图数据的生成、读写函数
 *   - PageRank 结果验证与输出函数
 *   - 计时工具
 *
 * 编译环境：C++17, g++, MSVC, clang 均兼容
 */

#ifndef PAGERANK_UTILS_H
#define PAGERANK_UTILS_H

#include <vector>
#include <string>
#include <random>
#include <algorithm>
#include <fstream>
#include <sstream>
#include <iostream>
#include <cmath>
#include <chrono>
#include <numeric>
#include <cassert>
#include <cstring>
#include <iomanip>

// ============================================================
// 图结构：CSR (Compressed Sparse Row) 格式
// ============================================================
/**
 * CSR 格式说明：
 *   row_ptr[i]   : 节点 i 的出边在 col_idx 中的起始位置
 *   row_ptr[i+1] : 节点 i 的出边在 col_idx 中的结束位置（不含）
 *   col_idx[k]   : 第 k 条边的目标节点编号
 *
 * 对于有向图 G=(V,E)，边 (u -> v) 表示 u 链接到 v。
 * 存储的是出边列表（正向图），用于计算被指向节点的 PR 贡献。
 *
 * 同时维护 in_edges 用于 MPI 场景下的入边快速查找。
 */
struct GraphCSR {
    int num_nodes;                   // 节点总数
    int num_edges;                   // 边总数
    std::vector<int> row_ptr;        // 大小 num_nodes + 1
    std::vector<int> col_idx;        // 大小 num_edges
    std::vector<int> out_degree;     // 每个节点的出度

    // 仅 MPI 版本使用：入边列表
    std::vector<std::vector<int>> in_edges; // in_edges[v] = 指向 v 的节点列表

    /**
     * 构建入边列表（从 CSR 出边列表转置得到）
     * MPI 版本需要按入边来计算 PR 值
     */
    void build_in_edges() {
        in_edges.resize(num_nodes);
        for (int u = 0; u < num_nodes; ++u) {
            for (int k = row_ptr[u]; k < row_ptr[u + 1]; ++k) {
                int v = col_idx[k];
                in_edges[v].push_back(u);
            }
        }
    }
};

// ============================================================
// 计时工具
// ============================================================
class Timer {
public:
    void start() { t0_ = std::chrono::high_resolution_clock::now(); }
    void stop()  { t1_ = std::chrono::high_resolution_clock::now(); }

    /** 返回毫秒 */
    double elapsed_ms() const {
        return std::chrono::duration<double, std::milli>(t1_ - t0_).count();
    }

    /** 返回秒 */
    double elapsed_s() const {
        return std::chrono::duration<double>(t1_ - t0_).count();
    }

private:
    std::chrono::high_resolution_clock::time_point t0_, t1_;
};

// ============================================================
// 图生成器
// ============================================================
/**
 * 生成随机有向图（边列表格式写入文件）
 *
 * @param filename   输出文件路径
 * @param num_nodes  节点数
 * @param avg_degree 每个节点的平均出度（控制图的稀疏度）
 * @param seed       随机种子（可复现）
 *
 * 文件格式：
 *   第1行：num_nodes num_edges
 *   后续每行：src dst（0-indexed 节点编号）
 *
 * 生成策略：对每个节点随机选择 avg_degree 个不同的目标节点，
 *           避免自环和重复边。
 */
inline void generate_graph(const std::string& filename, int num_nodes,
                           int avg_degree, unsigned seed = 42) {
    std::mt19937 rng(seed);
    std::ofstream ofs(filename);
    if (!ofs.is_open()) {
        std::cerr << "Error: cannot open " << filename << " for writing.\n";
        return;
    }

    // 收集所有边，去重
    std::vector<std::pair<int, int>> edges;
    edges.reserve(static_cast<size_t>(num_nodes) * avg_degree);

    std::uniform_int_distribution<int> dist(0, num_nodes - 1);

    for (int u = 0; u < num_nodes; ++u) {
        int deg = std::min(avg_degree, num_nodes - 1); // 最多 num_nodes-1 条出边（排除自环）
        int added = 0;
        std::vector<bool> used(num_nodes, false);
        used[u] = true; // 排除自环

        while (added < deg) {
            int v = dist(rng);
            if (!used[v]) {
                used[v] = true;
                edges.emplace_back(u, v);
                ++added;
            }
        }
    }

    // 按 (src, dst) 排序，便于后续构建 CSR
    std::sort(edges.begin(), edges.end());

    ofs << num_nodes << " " << edges.size() << "\n";
    for (auto& [u, v] : edges) {
        ofs << u << " " << v << "\n";
    }

    std::cout << "[GraphGen] Generated " << num_nodes << " nodes, "
              << edges.size() << " edges -> " << filename << "\n";
}

// ============================================================
// 从边列表文件加载图，构建 CSR 格式
// ============================================================
/**
 * 读取边列表文件并构建 CSR 格式的图结构。
 * 文件格式与 generate_graph 输出一致。
 *
 * 注意：使用输出参数而非返回值，以规避 g++ 15.2.0 在 -O1/-O2 下
 *       返回含 vector<vector<int>> 的大结构体时的 segfault bug。
 *
 * @param filename 边列表文件路径
 * @param g        [out] 输出的图结构
 */
inline void load_graph(const std::string& filename, GraphCSR& g) {
    std::ifstream ifs(filename);
    if (!ifs.is_open()) {
        std::cerr << "Error: cannot open " << filename << "\n";
        exit(1);
    }

    int n, m;
    ifs >> n >> m;

    std::vector<std::pair<int, int>> edges(m);
    for (int i = 0; i < m; ++i) {
        ifs >> edges[i].first >> edges[i].second;
    }

    // 排序（按 src, dst）
    std::sort(edges.begin(), edges.end());

    g.num_nodes = n;
    g.num_edges = m;
    g.row_ptr.resize(n + 1, 0);
    g.col_idx.resize(m);
    g.out_degree.resize(n, 0);
    g.in_edges.clear();

    // 统计每个节点的出度
    for (auto& [u, v] : edges) {
        g.out_degree[u]++;
    }

    // 构建 row_ptr（前缀和）
    g.row_ptr[0] = 0;
    for (int i = 0; i < n; ++i) {
        g.row_ptr[i + 1] = g.row_ptr[i] + g.out_degree[i];
    }

    // 填充 col_idx
    std::vector<int> offset(n, 0);
    for (auto& [u, v] : edges) {
        g.col_idx[g.row_ptr[u] + offset[u]] = v;
        offset[u]++;
    }

    std::cout << "[GraphLoad] " << n << " nodes, " << m << " edges loaded from "
              << filename << "\n";
}

// ============================================================
// PageRank 结果保存与验证
// ============================================================
/**
 * 将 PR 值写入文件（每行：节点编号 PR值）
 */
inline void save_pr(const std::string& filename, const std::vector<double>& pr) {
    std::ofstream ofs(filename);
    for (size_t i = 0; i < pr.size(); ++i) {
        ofs << i << " " << std::fixed << std::setprecision(10) << pr[i] << "\n";
    }
}

/**
 * 计算两个 PR 向量的 L2 范数差异，用于验证并行结果正确性
 */
inline double pr_l2_diff(const std::vector<double>& a, const std::vector<double>& b) {
    assert(a.size() == b.size());
    double sum = 0.0;
    for (size_t i = 0; i < a.size(); ++i) {
        double d = a[i] - b[i];
        sum += d * d;
    }
    return std::sqrt(sum);
}

/**
 * 计算 L1 范数差异
 */
inline double pr_l1_diff(const std::vector<double>& a, const std::vector<double>& b) {
    assert(a.size() == b.size());
    double sum = 0.0;
    for (size_t i = 0; i < a.size(); ++i) {
        sum += std::abs(a[i] - b[i]);
    }
    return sum;
}

/**
 * 打印 PR 值的统计信息
 */
inline void print_pr_stats(const std::vector<double>& pr, const std::string& label = "") {
    double sum = 0.0, minv = 1e18, maxv = -1e18;
    for (double v : pr) {
        sum += v;
        minv = std::min(minv, v);
        maxv = std::max(maxv, v);
    }
    std::cout << "[" << label << "] PR sum=" << sum
              << ", min=" << minv << ", max=" << maxv
              << ", avg=" << sum / pr.size() << "\n";
}

#endif // PAGERANK_UTILS_H
