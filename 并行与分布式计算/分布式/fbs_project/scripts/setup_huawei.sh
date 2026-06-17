#!/bin/bash
# ============================================================
# setup_huawei.sh - 华为云 ECS 服务器环境配置脚本
# ============================================================
#
# 适用系统：Ubuntu 22.04 / CentOS 7+ / EulerOS
#
# 用法：
#   1. 购买华为云 ECS（见下方说明）
#   2. SSH 登录服务器
#   3. 上传项目文件夹
#   4. 执行本脚本：
#      chmod +x scripts/setup_huawei.sh
#      ./scripts/setup_huawei.sh
#
# ============================================================

set -e

echo "========================================"
echo "  华为云环境配置 - PageRank 项目"
echo "========================================"
echo ""

# ---- 检测操作系统 ----
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    echo "Detected OS: $OS"
else
    echo "Cannot detect OS. Assuming Ubuntu."
    OS="ubuntu"
fi
echo ""

# ---- 更新系统包 ----
echo ">>> Step 1: Updating system packages..."
if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
    sudo apt-get update -y
    sudo apt-get upgrade -y
elif [ "$OS" = "centos" ] || [ "$OS" = "rhel" ] || [ "$OS" = "euleros" ]; then
    sudo yum update -y
fi
echo ""

# ---- 安装编译工具 ----
echo ">>> Step 2: Installing build tools..."
if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
    sudo apt-get install -y build-essential g++ make
elif [ "$OS" = "centos" ] || [ "$OS" = "rhel" ] || [ "$OS" = "euleros" ]; then
    sudo yum groupinstall -y "Development Tools"
    sudo yum install -y gcc-c++ make
fi
echo ""

# ---- 安装 OpenMP 支持（g++ 自带，确认版本）----
echo ">>> Step 3: Verifying OpenMP support..."
g++ --version
echo "OpenMP support: $(g++ -fopenmp -dM -E -x c++ /dev/null | grep _OPENMP | head -1 || echo 'checking...')"
# 测试编译
echo '#include <omp.h>
int main() { return omp_get_max_threads(); }' > /tmp/test_omp.cpp
if g++ -fopenmp /tmp/test_omp.cpp -o /tmp/test_omp 2>/dev/null; then
    echo "OpenMP: OK"
    rm -f /tmp/test_omp /tmp/test_omp.cpp
else
    echo "OpenMP: FAILED - trying to install libgomp..."
    if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
        sudo apt-get install -y libgomp1
    elif [ "$OS" = "centos" ] || [ "$OS" = "rhel" ] || [ "$OS" = "euleros" ]; then
        sudo yum install -y libgomp
    fi
fi
echo ""

# ---- 安装 MPI ----
echo ">>> Step 4: Installing MPI..."
if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
    sudo apt-get install -y openmpi-bin libopenmpi-dev
elif [ "$OS" = "centos" ] || [ "$OS" = "rhel" ] || [ "$OS" = "euleros" ]; then
    sudo yum install -y openmpi openmpi-devel
    # 添加 MPI 到 PATH
    echo 'export PATH=/usr/lib64/openmpi/bin:$PATH' >> ~/.bashrc
    echo 'export LD_LIBRARY_PATH=/usr/lib64/openmpi/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
    source ~/.bashrc
fi

# 验证 MPI
mpic++ --version && echo "MPI: OK" || echo "MPI: FAILED"
echo ""

# ---- 安装辅助工具 ----
echo ">>> Step 5: Installing auxiliary tools..."
if [ "$OS" = "ubuntu" ] || [ "$OS" = "debian" ]; then
    sudo apt-get install -y bc htop
elif [ "$OS" = "centos" ] || [ "$OS" = "rhel" ] || [ "$OS" = "euleros" ]; then
    sudo yum install -y bc htop
fi
echo ""

# ---- 编译项目 ----
echo ">>> Step 6: Building project..."
cd ~/fbs_project 2>/dev/null || cd "$(dirname "$0")/.."
make clean 2>/dev/null || true
make all
echo ""

# ---- 生成测试数据 ----
echo ">>> Step 7: Generating test data..."
make generate
echo ""

# ---- 验证安装 ----
echo ">>> Step 8: Quick verification..."
echo "Running quick serial test..."
./bin/pagerank_serial data/graph_1K.txt
echo ""
echo "Running quick OpenMP test (4 threads)..."
OMP_NUM_THREADS=4 ./bin/pagerank_openmp data/graph_1K.txt
echo ""
echo "Running quick MPI test (2 processes)..."
mpirun --allow-run-as-root -np 2 ./bin/pagerank_mpi data/graph_1K.txt
echo ""

echo "========================================"
echo "  环境配置完成！"
echo "========================================"
echo ""
echo "Next steps:"
echo "  1. Run full experiments: ./scripts/run_all_experiments.sh"
echo "  2. Copy results: scp user@server:~/fbs_project/results/experiment_results.csv ./"
echo ""
