/**
 * pagerank_mpi.cpp - MPI 并行 PageRank 算法
 *
 * 用法：
 *   mpirun -np 4 ./pagerank_mpi <graph_file> [damping] [tol] [max_iter]
 *
 * 并行策略：
 *   1. 图数据划分：按节点 ID 均匀划分到各进程
 *      - 每个进程负责 [start_v, end_v) 范围内节点的 PR 计算
 *      - 每个进程只存储其负责节点的入边信息（减少内存）
 *
 *   2. 通信方案：
 *      - 每轮迭代前，需要获取所有节点的当前 PR 值
 *      - 使用 MPI_Allgatherv 将各进程计算的新 PR 值广播给所有进程
 *      - 或者使用 MPI_Alltoallv 只交换边界节点（优化版本）
 *
 *   3. 悬挂节点处理：
 *      - 各进程本地计算其负责的悬挂节点 PR 之和
 *      - 通过 MPI_Allreduce 全局求和
 *
 *   4. 收敛判定：
 *      - 各进程本地计算负责节点的残差分量
 *      - 通过 MPI_Allreduce 全局求和后判断
 *
 * 正确性验证：
 *   与串行结果对比，所有节点的 PR 值应一致（数值精度内）
 */

#include "utils.h"
#include <iostream>
#include <string>
#include <iomanip>
#include <mpi.h>

/**
 * MPI 并行 PageRank
 *
 * @param g          完整图结构（所有进程都有完整图，但只计算自己的部分）
 * @param rank       当前进程编号
 * @param size       总进程数
 * @param damping    阻尼因子
 * @param tol        收敛阈值
 * @param max_iter   最大迭代次数
 * @param pr         [out] 完整 PR 向量（所有进程一致）
 * @param iterations [out] 实际迭代次数
 * @param residual   [out] 最终残差
 * @param elapsed_ms [out] 计算耗时
 */
void pagerank_mpi(const GraphCSR& g, int rank, int size,
                  double damping, double tol, int max_iter,
                  std::vector<double>& pr, int& iterations,
                  double& residual, double& elapsed_ms) {
    int n = g.num_nodes;

    // ---- 划分节点范围 ----
    // 均匀划分：每个进程负责 roughly n/size 个节点
    int base_count = n / size;
    int remainder  = n % size;

    // 前 remainder 个进程多分一个节点
    int local_start, local_count;
    if (rank < remainder) {
        local_count = base_count + 1;
        local_start = rank * local_count;
    } else {
        local_count = base_count;
        local_start = remainder * (base_count + 1) + (rank - remainder) * base_count;
    }
    int local_end = local_start + local_count;

    // 为 MPI_Allgatherv 准备参数
    std::vector<int> recv_counts(size), displs(size);
    for (int i = 0; i < size; ++i) {
        if (i < remainder) {
            recv_counts[i] = base_count + 1;
            displs[i] = i * (base_count + 1);
        } else {
            recv_counts[i] = base_count;
            displs[i] = remainder * (base_count + 1) + (i - remainder) * base_count;
        }
    }

    // ---- 初始化 PR 值 ----
    double init_val = 1.0 / n;
    pr.assign(n, init_val);
    std::vector<double> pr_new(local_count, 0.0); // 只存储本地负责的部分

    // ---- MPI 计时 ----
    MPI_Barrier(MPI_COMM_WORLD);
    double t_start = MPI_Wtime();

    for (int iter = 0; iter < max_iter; ++iter) {

        // ---- Step 1: 计算悬挂节点贡献（全局 reduction）----
        double local_dangling = 0.0;
        for (int u = local_start; u < local_end; ++u) {
            if (g.out_degree[u] == 0) {
                local_dangling += pr[u];
            }
        }
        double global_dangling = 0.0;
        MPI_Allreduce(&local_dangling, &global_dangling, 1, MPI_DOUBLE,
                      MPI_SUM, MPI_COMM_WORLD);
        double dangling_contrib = damping * global_dangling / n;

        // ---- Step 2: 每个进程计算负责节点的新 PR 值 ----
        for (int v = local_start; v < local_end; ++v) {
            double sum = 0.0;
            for (int u : g.in_edges[v]) {
                sum += pr[u] / g.out_degree[u];
            }
            pr_new[v - local_start] =
                (1.0 - damping) / n + dangling_contrib + damping * sum;
        }

        // ---- Step 3: 收集所有进程的新 PR 值到完整向量 ----
        MPI_Allgatherv(pr_new.data(), local_count, MPI_DOUBLE,
                        pr.data(), recv_counts.data(), displs.data(),
                        MPI_DOUBLE, MPI_COMM_WORLD);

        // ---- Step 4: 计算残差（本地部分 + 全局归约）----
        // 注意：这里用的是上一轮的 pr（Allgatherv 后已更新）和本轮的 pr_new
        // 但 pr 已经被 Allgatherv 覆盖了，所以我们需要在 Allgatherv 前保存旧值
        // 修正：在 Step 2 前保存旧 PR 值
        // 由于 pr_new 只有本地部分，残差也只算本地部分
        // 重新组织逻辑 -> 见下方修正版本

        // 为了避免复杂化，我们在 Allgatherv 之后再算一次残差
        // 这需要旧 PR 值 -> 用另一个数组保存
        // （在下面的修正版中处理）
    }

    // === 修正版：完整实现 ===
    // 上面的框架有残差计算的逻辑问题，下面给出完整正确版本
    pr.assign(n, init_val);
    std::vector<double> pr_old(n, 0.0);
    pr_new.assign(local_count, 0.0);

    iterations = 0;
    residual = 0.0;

    for (int iter = 0; iter < max_iter; ++iter) {
        // 保存旧 PR 值
        pr_old = pr;

        // 悬挂节点贡献
        double local_dangling = 0.0;
        for (int u = local_start; u < local_end; ++u) {
            if (g.out_degree[u] == 0) {
                local_dangling += pr[u];
            }
        }
        double global_dangling = 0.0;
        MPI_Allreduce(&local_dangling, &global_dangling, 1, MPI_DOUBLE,
                      MPI_SUM, MPI_COMM_WORLD);
        double dangling_contrib = damping * global_dangling / n;

        // 计算本地节点的新 PR 值
        for (int v = local_start; v < local_end; ++v) {
            double sum = 0.0;
            for (int u : g.in_edges[v]) {
                sum += pr[u] / g.out_degree[u];
            }
            pr_new[v - local_start] =
                (1.0 - damping) / n + dangling_contrib + damping * sum;
        }

        // 计算本地残差分量（在 Allgatherv 之前）
        double local_diff = 0.0;
        for (int i = 0; i < local_count; ++i) {
            local_diff += std::abs(pr_new[i] - pr_old[local_start + i]);
        }
        double global_diff = 0.0;
        MPI_Allreduce(&local_diff, &global_diff, 1, MPI_DOUBLE,
                      MPI_SUM, MPI_COMM_WORLD);

        // 收集新 PR 值
        MPI_Allgatherv(pr_new.data(), local_count, MPI_DOUBLE,
                        pr.data(), recv_counts.data(), displs.data(),
                        MPI_DOUBLE, MPI_COMM_WORLD);

        iterations = iter + 1;
        residual = global_diff;

        if (global_diff < tol) {
            break;
        }
    }

    double t_end = MPI_Wtime();
    elapsed_ms = (t_end - t_start) * 1000.0;
}

// ============================================================
// 主函数
// ============================================================
int main(int argc, char* argv[]) {
    MPI_Init(&argc, &argv);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // 只有 rank 0 打印信息
    if (rank == 0) {
        std::cout << "========================================\n";
        std::cout << "  PageRank MPI 并行算法实验\n";
        std::cout << "========================================\n";
        std::cout << "Processes: " << size << "\n\n";
    }

    if (argc < 2) {
        if (rank == 0)
            std::cerr << "Usage: mpirun -np N " << argv[0]
                      << " <graph_file> [damping] [tol] [max_iter]\n";
        MPI_Finalize();
        return 1;
    }

    std::string graph_file = argv[1];
    double damping = (argc >= 3) ? std::stod(argv[2]) : 0.85;
    double tol     = (argc >= 4) ? std::stod(argv[3]) : 1e-6;
    int max_iter   = (argc >= 5) ? std::stoi(argv[4]) : 100;

    // 所有进程加载完整图（简化实现；大规模场景应使用分布式图加载）
    GraphCSR g;
    load_graph(graph_file, g);
    g.build_in_edges();

    std::vector<double> pr;
    int iters;
    double residual, elapsed_ms;

    pagerank_mpi(g, rank, size, damping, tol, max_iter, pr, iters,
                 residual, elapsed_ms);

    // rank 0 输出结果
    if (rank == 0) {
        double pr_sum = 0.0;
        for (double v : pr) pr_sum += v;

        std::cout << std::left
                  << std::setw(10) << "Procs"
                  << std::setw(10) << "Iters"
                  << std::setw(14) << "Time(ms)"
                  << std::setw(14) << "Residual"
                  << std::setw(14) << "PR_Sum"
                  << "\n";
        std::cout << std::string(60, '-') << "\n";

        std::cout << std::left
                  << std::setw(10) << size
                  << std::setw(10) << iters
                  << std::setw(14) << std::fixed << std::setprecision(2) << elapsed_ms
                  << std::setw(14) << std::scientific << std::setprecision(4) << residual
                  << std::setw(14) << std::fixed << std::setprecision(6) << pr_sum
                  << "\n";

        // 保存结果
        std::string out_file = "results/mpi_p" + std::to_string(size) + "_"
                               + graph_file.substr(graph_file.rfind('/') + 1);
        save_pr(out_file, pr);
        std::cout << "\nResults saved to " << out_file << "\n";
    }

    MPI_Finalize();
    return 0;
}
