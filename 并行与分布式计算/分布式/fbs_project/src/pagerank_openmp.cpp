/**
 * pagerank_openmp.cpp - OpenMP 并行 PageRank 算法
 *
 * 用法：
 *   OMP_NUM_THREADS=4 ./pagerank_openmp <graph_file> [damping] [tol] [max_iter]
 *
 * 环境变量：
 *   OMP_NUM_THREADS : 设置线程数（也可在代码中用 omp_set_num_threads()）
 *
 * 并行策略：
 *   1. 节点级并行：将 N 个节点的 PR 计算分配给多个线程
 *   2. 使用入边列表（预构建），每个线程独立计算负责节点的新 PR 值
 *   3. 使用 #pragma omp parallel for schedule(dynamic) 处理负载不均衡
 *      （图中节点入边数差异大，动态调度更优）
 *   4. 悬挂节点贡献通过 reduction 求和
 *   5. 残差计算使用 reduction 求和
 *   6. 每轮迭代结束隐式 barrier 同步
 *
 * 正确性验证：
 *   与串行结果对比 L1/L2 范数差异，应小于数值精度误差（~1e-10）
 *
 * 性能指标：
 *   记录不同线程数下的运行时间，用于计算加速比和并行效率
 */

#include "utils.h"
#include <iostream>
#include <string>
#include <iomanip>
#include <omp.h>

/**
 * OpenMP 并行 PageRank
 *
 * @param g          CSR 格式的图（需已构建 in_edges）
 * @param damping    阻尼因子
 * @param tol        收敛阈值
 * @param max_iter   最大迭代次数
 * @param pr         [out] 最终 PR 值
 * @param iterations [out] 实际迭代次数
 * @param residual   [out] 最终残差
 * @param elapsed_ms [out] 计算耗时
 */
void pagerank_openmp(const GraphCSR& g, double damping, double tol,
                     int max_iter, std::vector<double>& pr,
                     int& iterations, double& residual, double& elapsed_ms) {
    int n = g.num_nodes;
    double init_val = 1.0 / n;

    pr.assign(n, init_val);
    std::vector<double> pr_new(n, 0.0);

    Timer timer;
    timer.start();

    for (int iter = 0; iter < max_iter; ++iter) {

        // ---- Step 1: 计算悬挂节点贡献（并行 reduction）----
        double dangling_sum = 0.0;
        #pragma omp parallel for reduction(+:dangling_sum) schedule(static)
        for (int u = 0; u < n; ++u) {
            if (g.out_degree[u] == 0) {
                dangling_sum += pr[u];
            }
        }
        double dangling_contrib = damping * dangling_sum / n;

        // ---- Step 2: 并行计算每个节点的新 PR 值 ----
        // schedule(dynamic) 因为节点入边数差异大（幂律分布），
        // 动态调度让处理完的线程可以继续处理剩余节点，减少等待
        #pragma omp parallel for schedule(dynamic, 64)
        for (int v = 0; v < n; ++v) {
            double sum = 0.0;
            // 遍历所有指向 v 的节点
            for (int u : g.in_edges[v]) {
                sum += pr[u] / g.out_degree[u];
            }
            pr_new[v] = (1.0 - damping) / n + dangling_contrib + damping * sum;
        }

        // ---- Step 3: 并行计算 L1 残差 ----
        double diff = 0.0;
        #pragma omp parallel for reduction(+:diff) schedule(static)
        for (int i = 0; i < n; ++i) {
            diff += std::abs(pr_new[i] - pr[i]);
        }

        // 交换（单线程操作，开销可忽略）
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
// 主函数：多线程数批量实验 + 正确性验证
// ============================================================
int main(int argc, char* argv[]) {
    std::cout << "========================================\n";
    std::cout << "  PageRank OpenMP 并行算法实验\n";
    std::cout << "========================================\n\n";

    if (argc < 2) {
        std::cerr << "Usage: " << argv[0]
                  << " <graph_file> [damping] [tol] [max_iter]\n";
        return 1;
    }

    std::string graph_file = argv[1];
    double damping = (argc >= 3) ? std::stod(argv[2]) : 0.85;
    double tol     = (argc >= 4) ? std::stod(argv[3]) : 1e-6;
    int max_iter   = (argc >= 5) ? std::stoi(argv[4]) : 100;

    GraphCSR g;
    load_graph(graph_file, g);
    g.build_in_edges(); // OpenMP 版本需要入边列表

    // 测试的线程数列表
    std::vector<int> thread_counts = {1, 2, 4, 8, 16};
    // 过滤掉超过系统最大线程数的值
    int max_threads = omp_get_max_threads();
    std::cout << "System max threads: " << max_threads << "\n\n";

    // 保存串行基准结果（1线程时的结果即为基准）
    std::vector<double> baseline_pr;
    double baseline_time = 0.0;

    // 表头
    std::cout << std::left
              << std::setw(10) << "Threads"
              << std::setw(10) << "Iters"
              << std::setw(14) << "Time(ms)"
              << std::setw(14) << "Speedup"
              << std::setw(14) << "Efficiency"
              << std::setw(14) << "L1_diff"
              << std::setw(14) << "PR_Sum"
              << "\n";
    std::cout << std::string(90, '-') << "\n";

    for (int tc : thread_counts) {
        if (tc > max_threads) continue;

        omp_set_num_threads(tc);

        std::vector<double> pr;
        int iters;
        double residual, elapsed_ms;

        pagerank_openmp(g, damping, tol, max_iter, pr, iters, residual,
                        elapsed_ms);

        // 第一次（1线程）作为基准
        if (tc == 1) {
            baseline_pr = pr;
            baseline_time = elapsed_ms;
        }

        double speedup = baseline_time / elapsed_ms;
        double efficiency = speedup / tc;
        double l1_diff = (tc == 1) ? 0.0 : pr_l1_diff(baseline_pr, pr);

        double pr_sum = 0.0;
        for (double v : pr) pr_sum += v;

        std::cout << std::left
                  << std::setw(10) << tc
                  << std::setw(10) << iters
                  << std::setw(14) << std::fixed << std::setprecision(2) << elapsed_ms
                  << std::setw(14) << std::setprecision(4) << speedup
                  << std::setw(14) << std::setprecision(4) << efficiency
                  << std::setw(14) << std::scientific << std::setprecision(4) << l1_diff
                  << std::setw(14) << std::fixed << std::setprecision(6) << pr_sum
                  << "\n";

        // 保存结果
        std::string out_file = "results/openmp_t" + std::to_string(tc) + "_"
                               + graph_file.substr(graph_file.rfind('/') + 1);
        save_pr(out_file, pr);
    }

    std::cout << "\nBaseline (1 thread) time: " << baseline_time << " ms\n";
    std::cout << "Results saved to results/ directory.\n";
    return 0;
}
