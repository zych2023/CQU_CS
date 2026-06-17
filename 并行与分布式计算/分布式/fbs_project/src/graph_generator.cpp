/**
 * graph_generator.cpp - 图数据生成器
 *
 * 用法：
 *   ./graph_generator
 *
 * 生成多个不同规模的随机有向图，用于后续 PageRank 实验。
 * 图规模：1K, 5K, 10K, 50K, 100K 节点
 * 平均出度：10（模拟网页链接的稀疏特性）
 *
 * 输出文件保存在 data/ 目录下，格式为边列表：
 *   第1行：num_nodes num_edges
 *   后续行：src dst
 */

#include "utils.h"
#include <iostream>
#include <string>

int main() {
    std::cout << "========================================\n";
    std::cout << "  PageRank 图数据生成器\n";
    std::cout << "========================================\n\n";

    // 实验用的图规模列表
    struct GraphSpec {
        int nodes;
        int avg_degree;
        std::string name;
    };

    std::vector<GraphSpec> specs = {
        {1000,   10, "graph_1K"},
        {5000,   10, "graph_5K"},
        {10000,  10, "graph_10K"},
        {50000,  10, "graph_50K"},
        {100000, 10, "graph_100K"},
    };

    for (auto& spec : specs) {
        std::string path = "data/" + spec.name + ".txt";
        generate_graph(path, spec.nodes, spec.avg_degree, 42);
    }

    std::cout << "\nAll graphs generated successfully.\n";
    std::cout << "Files are in the data/ directory.\n";
    return 0;
}
