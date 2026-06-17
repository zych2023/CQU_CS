/**
 * pagerank_serial.cpp - 串行 PageRank 算法实现
 *
 * 用法：
 *   ./pagerank_serial <graph_file> [damping_factor] [tolerance] [max_iterations]
 *
 * 参数：
 *   graph_file       : 边列表文件路径（由 graph_generator 生成）
 *   damping_factor   : 阻尼因子，默认 0.85
 *   tolerance        : 收敛阈值（L1 范数），默认 1e-6
 *   max_iterations   : 最大迭代次数，默认 100
 *
 * 输出：
 *   - 迭代次数、运行时间、收敛残差
 *   - PR 值统计信息（sum, min, max, avg）
 *   - PR 结果写入 results/ 目录
 *
 * 算法说明：
 *   使用幂迭代法（Power Iteration）计算 PageRank。
 *   每轮迭代对所有节点计算新 PR 值：
 *     PR_new(v) = (1-d)/N + d * Σ_{u∈In(v)} PR(u)/out_degree(u)
 *   当 L1 残差 < tolerance 时判定收敛。
 *
 *   对于出度为 0 的"悬挂节点"（dangling node），
 *   其 PR 值均匀分配给所有节点（经典处理方式）。
 */

#include "utils.h"
#include <iostream>
#include <string>
#include <iomanip>

/**
 * 串行 PageRank 核心计算
 *
 * @param g          CSR 格式的图
 * @param damping    阻尼因子
 * @param tol        收敛阈值
 * @param max_iter   最大迭代次数
 * @param pr         [out] 最终 PR 值向量
 * @param iterations [out] 实际迭代次数
 * @param residual   [out] 最终残差
 * @param elapsed_ms [out] 计算耗时（毫秒）
 */
void pagerank_serial(const GraphCSR& g, double damping, double tol,
                     int max_iter, std::vector<double>& pr,
                     int& iterations, double& residual, double& elapsed_ms) {
    int n = g.num_nodes;
    double init_val = 1.0 / n;

    // 初始化 PR 值为 1/N
    pr.assign(n, init_val);
    std::vector<double> pr_new(n, 0.0);

    Timer timer;
    timer.start();

    for (int iter = 0; iter < max_iter; ++iter) {
        // ---- 计算悬挂节点的 PR 贡献 ----
        // 悬挂节点：出度为 0 的节点，其 PR 值均匀分给所有节点
        double dangling_sum = 0.0;
        for (int u = 0; u < n; ++u) {
            if (g.out_degree[u] == 0) {
                dangling_sum += pr[u];
            }
        }
        double dangling_contrib = damping * dangling_sum / n;

        // ---- 对每个节点计算新 PR 值 ----
        for (int v = 0; v < n; ++v) {
            double sum = 0.0;
            // 遍历所有指向 v 的节点 u
            // 由于 CSR 存储的是出边，这里需要遍历整个图来找入边
            // （优化：可预先构建入边列表，但串行版本保持简洁）
            for (int u = 0; u < n; ++u) {
                for (int k = g.row_ptr[u]; k < g.row_ptr[u + 1]; ++k) {
                    if (g.col_idx[k] == v) {
                        sum += pr[u] / g.out_degree[u];
                    }
                }
            }
            pr_new[v] = (1.0 - damping) / n + dangling_contrib + damping * sum;
        }

        // ---- 计算 L1 残差 ----
        double diff = 0.0;
        for (int i = 0; i < n; ++i) {
            diff += std::abs(pr_new[i] - pr[i]);
        }

        // 交换新旧 PR 向量
        std::swap(pr, pr_new);

        iterations = iter + 1;
        residual = diff;

        // 收敛判定
        if (diff < tol) {
            break;
        }
    }

    timer.stop();
    elapsed_ms = timer.elapsed_ms();
}

/**
 * 优化版本：使用入边列表，避免 O(n^2) 扫描
 * 性能远优于上面的基础版本
 */
void pagerank_serial_optimized(const GraphCSR& g, double damping, double tol,
                               int max_iter, std::vector<double>& pr,
                               int& iterations, double& residual,
                               double& elapsed_ms) {
    int n = g.num_nodes;

    // 构建入边列表（一次性开销，避免复制整个 GraphCSR 结构体）
    std::vector<std::vector<int>> in_edges(n);
    for (int u = 0; u < n; ++u) {
        for (int k = g.row_ptr[u]; k < g.row_ptr[u + 1]; ++k) {
            int v = g.col_idx[k];
            in_edges[v].push_back(u);
        }
    }

    double init_val = 1.0 / n;
    pr.assign(n, init_val);
    std::vector<double> pr_new(n, 0.0);

    Timer timer;
    timer.start();

    for (int iter = 0; iter < max_iter; ++iter) {
        // 悬挂节点贡献
        double dangling_sum = 0.0;
        for (int u = 0; u < n; ++u) {
            if (g.out_degree[u] == 0) {
                dangling_sum += pr[u];
            }
        }
        double dangling_contrib = damping * dangling_sum / n;

        // 对每个节点：利用入边列表直接求和，O(|E|) 总复杂度
        for (int v = 0; v < n; ++v) {
            double sum = 0.0;
            for (int u : in_edges[v]) {
                sum += pr[u] / g.out_degree[u];
            }
            pr_new[v] = (1.0 - damping) / n + dangling_contrib + damping * sum;
        }

        // L1 残差
        double diff = 0.0;
        for (int i = 0; i < n; ++i) {
            diff += std::abs(pr_new[i] - pr[i]);
        }

        std::swap(pr, pr_new);
        iterations = iter + 1;
        residual = diff;

        if (diff < tol) {
            break;
        }
    }

    timer.stop();
    elapsed_ms = timer.elapsed_ms();
}

// ============================================================
// 主函数：批量实验
// ============================================================
int main(int argc, char* argv[]) {
    std::cout << "========================================\n";
    std::cout << "  PageRank 串行算法实验\n";
    std::cout << "========================================\n\n";

    // 如果指定了单个文件则只跑该文件，否则批量跑所有 data/graph_*.txt
    std::vector<std::string> files;
    if (argc >= 2) {
        files.push_back(argv[1]);
    } else {
        // 默认批量实验
        std::vector<std::string> names = {
            "graph_1K", "graph_5K", "graph_10K", "graph_50K", "graph_100K"
        };
        for (auto& name : names) {
            files.push_back("data/" + name + ".txt");
        }
    }

    double damping = 0.85;
    double tol = 1e-6;
    int max_iter = 100;

    if (argc >= 3) damping = std::stod(argv[2]);
    if (argc >= 4) tol = std::stod(argv[3]);
    if (argc >= 5) max_iter = std::stoi(argv[4]);

    // 表头
    std::cout << std::left
              << std::setw(16) << "Graph"
              << std::setw(10) << "Nodes"
              << std::setw(12) << "Edges"
              << std::setw(10) << "Iters"
              << std::setw(14) << "Time(ms)"
              << std::setw(14) << "Residual"
              << std::setw(14) << "PR_Sum"
              << "\n";
    std::cout << std::string(90, '-') << "\n";

    for (auto& file : files) {
        GraphCSR g;
        load_graph(file, g);

        std::vector<double> pr;
        int iters;
        double residual, elapsed_ms;

        // 使用优化版本
        pagerank_serial_optimized(g, damping, tol, max_iter, pr, iters,
                                  residual, elapsed_ms);

        double pr_sum = 0.0;
        for (double v : pr) pr_sum += v;

        // 提取文件名（去掉路径前缀）
        std::string name = file;
        auto pos = name.rfind('/');
        if (pos != std::string::npos) name = name.substr(pos + 1);
        pos = name.rfind('\\');
        if (pos != std::string::npos) name = name.substr(pos + 1);

        std::cout << std::left
                  << std::setw(16) << name
                  << std::setw(10) << g.num_nodes
                  << std::setw(12) << g.num_edges
                  << std::setw(10) << iters
                  << std::setw(14) << std::fixed << std::setprecision(2) << elapsed_ms
                  << std::setw(14) << std::scientific << std::setprecision(4) << residual
                  << std::setw(14) << std::fixed << std::setprecision(6) << pr_sum
                  << "\n";

        // 保存结果
        std::string out_name = "results/serial_" + name;
        save_pr(out_name, pr);
    }

    std::cout << "\nResults saved to results/ directory.\n";
    return 0;
}
