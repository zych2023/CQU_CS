#!/bin/bash
# ============================================================
# run_mpi_multinode.sh - 多节点 MPI 实验脚本
# ============================================================
#
# 在华为云多台 ECS 上运行 MPI PageRank
#
# 前置条件：
#   1. 所有节点已安装 MPI
#   2. 所有节点之间 SSH 免密登录已配置
#   3. 项目代码已上传到所有节点的相同路径
#   4. 图数据文件已上传到所有节点
#
# 用法：
#   1. 编辑下方 NODES 数组，填入各节点 IP
#   2. 在主节点执行：
#      chmod +x scripts/run_mpi_multinode.sh
#      ./scripts/run_mpi_multinode.sh
#
# ============================================================

set -e

# ============================================================
# 配置区域 - 请修改为实际的节点 IP
# ============================================================
NODES=(
    "192.168.1.101"   # 主节点
    "192.168.1.102"   # 从节点1
    "192.168.1.103"   # 从节点2
    "192.168.1.104"   # 从节点3
)
PROJECT_DIR=~/fbs_project
GRAPHS=("data/graph_10K.txt" "data/graph_50K.txt" "data/graph_100K.txt")

# ============================================================
# 生成 hostfile
# ============================================================
echo "Generating MPI hostfile..."
HOSTFILE=${PROJECT_DIR}/hostfile
> ${HOSTFILE}
for node in "${NODES[@]}"; do
    echo "${node} slots=1" >> ${HOSTFILE}
done
cat ${HOSTFILE}
echo ""

# ============================================================
# 同步代码到所有节点
# ============================================================
echo "Syncing code to all nodes..."
for node in "${NODES[@]}"; do
    if [ "${node}" != "127.0.0.1" ] && [ "${node}" != "localhost" ]; then
        echo "  Syncing to ${node}..."
        rsync -avz --exclude='bin/' --exclude='results/' \
            ${PROJECT_DIR}/ user@${node}:${PROJECT_DIR}/
    fi
done
echo ""

# ============================================================
# 在所有节点编译
# ============================================================
echo "Compiling on all nodes..."
for node in "${NODES[@]}"; do
    echo "  Compiling on ${node}..."
    ssh user@${node} "cd ${PROJECT_DIR} && make mpi" &
done
wait
echo ""

# ============================================================
# 运行多节点 MPI 实验
# ============================================================
echo "========================================"
echo "  Running multi-node MPI experiments"
echo "========================================"

NUM_NODES=${#NODES[@]}
RESULTS_DIR=${PROJECT_DIR}/results
mkdir -p ${RESULTS_DIR}

for graph in "${GRAPHS[@]}"; do
    echo ""
    echo ">>> Graph: ${graph}"
    echo "  Nodes: ${NUM_NODES}"

    # 使用 hostfile 运行
    mpirun --allow-run-as-root \
           --hostfile ${HOSTFILE} \
           -np ${NUM_NODES} \
           ${PROJECT_DIR}/bin/pagerank_mpi ${graph}

    echo "  Done."
done

echo ""
echo "========================================"
echo "  Multi-node experiments complete!"
echo "========================================"
echo "Results are in ${RESULTS_DIR}/"
