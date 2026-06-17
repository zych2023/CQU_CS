#!/bin/bash
# 节点环境配置脚本
# 用法: bash setup_node.sh

echo "========================================="
echo "配置OpenMP和MPI混合编程环境"
echo "========================================="

# 更新系统
echo "[1/4] 更新系统包..."
apt update -y

# 安装编译工具
echo "[2/4] 安装编译工具..."
apt install -y build-essential g++

# 安装OpenMPI
echo "[3/4] 安装OpenMPI..."
apt install -y openmpi-bin openmpi-common libopenmpi-dev

# 验证安装
echo "[4/4] 验证安装..."
echo ""
echo "=== 编译器版本 ==="
g++ --version | head -1
echo ""
echo "=== MPI版本 ==="
mpicc --version | head -1
mpirun --version | head -1
echo ""
echo "=== OpenMP支持 ==="
echo | cpp -fopenmp -dM | grep -i openmp | head -3
echo ""
echo "========================================="
echo "环境配置完成！"
echo "========================================="
