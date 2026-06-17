#!/bin/bash
# ============================================================
# run_all_experiments.sh - PageRank 全量实验脚本
# ============================================================
# 用法：
#   chmod +x scripts/run_all_experiments.sh
#   ./scripts/run_all_experiments.sh
#
# 前置条件：
#   - 已编译所有目标（make all）
#   - 已生成图数据（make generate）
#   - MPI 环境已配置
#
# 实验内容：
#   1. 串行版本：不同图规模下的运行时间
#   2. OpenMP 版本：不同线程数下的运行时间
#   3. MPI 版本：不同进程数下的运行时间
#   4. 汇总结果到 CSV 文件
# ============================================================

set -e  # 遇错停止

echo "========================================"
echo "  PageRank 全量实验"
echo "========================================"
echo ""

# 配置
GRAPHS=("data/graph_1K.txt" "data/graph_5K.txt" "data/graph_10K.txt" "data/graph_50K.txt" "data/graph_100K.txt")
THREAD_COUNTS=(1 2 4 8 16)
PROC_COUNTS=(1 2 4 8 16)
RESULTS_DIR="results"
CSV_FILE="${RESULTS_DIR}/experiment_results.csv"

mkdir -p ${RESULTS_DIR}

# CSV 表头
echo "experiment,graph,nodes,edges,config,time_ms,iterations,residual,speedup,efficiency" > ${CSV_FILE}

# ============================================================
# 实验1：串行版本
# ============================================================
echo ">>> Experiment 1: Serial PageRank"
echo "========================================"

for graph in "${GRAPHS[@]}"; do
    echo "  Running serial on ${graph}..."
    output=$(./bin/pagerank_serial ${graph} 2>&1)
    # 提取结果行（跳过表头和分隔线）
    result=$(echo "${output}" | grep "graph_" | head -1)
    if [ -n "$result" ]; then
        name=$(echo "${result}" | awk '{print $1}')
        nodes=$(echo "${result}" | awk '{print $2}')
        edges=$(echo "${result}" | awk '{print $3}')
        iters=$(echo "${result}" | awk '{print $4}')
        time_ms=$(echo "${result}" | awk '{print $5}')
        residual=$(echo "${result}" | awk '{print $6}')
        echo "serial,${name},${nodes},${edges},1,${time_ms},${iters},${residual},1.0000,1.0000" >> ${CSV_FILE}
    fi
done
echo ""

# ============================================================
# 实验2：OpenMP 版本
# ============================================================
echo ">>> Experiment 2: OpenMP PageRank"
echo "========================================"

for graph in "${GRAPHS[@]}"; do
    for tc in "${THREAD_COUNTS[@]}"; do
        echo "  Running OpenMP on ${graph} with ${tc} threads..."
        export OMP_NUM_THREADS=${tc}
        output=$(./bin/pagerank_openmp ${graph} 2>&1)
        # 提取每个线程数的结果
        result=$(echo "${output}" | grep -E "^[[:space:]]*${tc}" | head -1)
        if [ -n "$result" ]; then
            iters=$(echo "${result}" | awk '{print $2}')
            time_ms=$(echo "${result}" | awk '{print $3}')
            speedup=$(echo "${result}" | awk '{print $4}')
            efficiency=$(echo "${result}" | awk '{print $5}')
            residual=$(echo "${result}" | awk '{print $6}')
            nodes=$(echo "${output}" | grep "nodes" | head -1 | awk '{print $1}')
            edges=$(echo "${output}" | grep "edges" | head -1 | awk '{print $3}')
            echo "openmp,${graph},${nodes},${edges},${tc},${time_ms},${iters},${residual},${speedup},${efficiency}" >> ${CSV_FILE}
        fi
    done
done
echo ""

# ============================================================
# 实验3：MPI 版本
# ============================================================
echo ">>> Experiment 3: MPI PageRank"
echo "========================================"

# 获取串行基准时间（用于计算加速比）
declare -A SERIAL_TIMES
for graph in "${GRAPHS[@]}"; do
    output=$(./bin/pagerank_serial ${graph} 2>&1)
    result=$(echo "${output}" | grep "graph_" | head -1)
    if [ -n "$result" ]; then
        SERIAL_TIMES[${graph}]=$(echo "${result}" | awk '{print $5}')
    fi
done

for graph in "${GRAPHS[@]}"; do
    for pc in "${PROC_COUNTS[@]}"; do
        echo "  Running MPI on ${graph} with ${pc} processes..."
        output=$(mpirun --allow-run-as-root -np ${pc} ./bin/pagerank_mpi ${graph} 2>&1)
        # 提取结果
        result=$(echo "${output}" | grep -E "^[[:space:]]*${pc}" | head -1)
        if [ -n "$result" ]; then
            iters=$(echo "${result}" | awk '{print $2}')
            time_ms=$(echo "${result}" | awk '{print $3}')
            residual=$(echo "${result}" | awk '{print $4}')
            # 计算加速比和并行效率
            serial_time=${SERIAL_TIMES[${graph}]}
            if [ -n "${serial_time}" ] && [ "${time_ms}" != "0" ]; then
                speedup=$(echo "scale=4; ${serial_time} / ${time_ms}" | bc)
                efficiency=$(echo "scale=4; ${speedup} / ${pc}" | bc)
            else
                speedup="N/A"
                efficiency="N/A"
            fi
            nodes=$(echo "${output}" | grep "nodes" | head -1 | awk '{print $1}')
            edges=$(echo "${output}" | grep "edges" | head -1 | awk '{print $3}')
            echo "mpi,${graph},${nodes},${edges},${pc},${time_ms},${iters},${residual},${speedup},${efficiency}" >> ${CSV_FILE}
        fi
    done
done
echo ""

# ============================================================
# 结果汇总
# ============================================================
echo "========================================"
echo "  实验完成！"
echo "========================================"
echo ""
echo "Results CSV: ${CSV_FILE}"
echo ""
echo "CSV preview:"
head -20 ${CSV_FILE}
echo ""
echo "To copy results to local machine:"
echo "  scp user@server:~/fbs_project/${CSV_FILE} ./"
