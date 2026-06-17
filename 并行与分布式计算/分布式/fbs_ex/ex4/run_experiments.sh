#!/bin/bash
# 运行实验脚本
# 用法: bash run_experiments.sh

# 允许root用户运行MPI
export OMPI_ALLOW_RUN_AS_ROOT=1
export OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

HOSTFILE="hostfile"
RESULTS_FILE="results.txt"

echo "=========================================" | tee $RESULTS_FILE
echo "实验四：OpenMP与MPI混合编程实验" | tee -a $RESULTS_FILE
echo "=========================================" | tee -a $RESULTS_FILE
echo "" | tee -a $RESULTS_FILE

# 记录系统信息
echo "系统信息:" | tee -a $RESULTS_FILE
echo "节点: $(hostname)" | tee -a $RESULTS_FILE
echo "CPU: $(nproc) 核" | tee -a $RESULTS_FILE
echo "内存: $(free -h | awk '/^Mem:/{print $2}')" | tee -a $RESULTS_FILE
echo "" | tee -a $RESULTS_FILE

# 获取所有节点名称
echo "使用的节点:" | tee -a $RESULTS_FILE
mpirun -np 4 --hostfile $HOSTFILE hostname | sort | tee -a $RESULTS_FILE
echo "" | tee -a $RESULTS_FILE

echo "=========================================" | tee -a $RESULTS_FILE
echo "按行并行实验" | tee -a $RESULTS_FILE
echo "=========================================" | tee -a $RESULTS_FILE

# 进程数=1，不使用OpenMP
echo "" | tee -a $RESULTS_FILE
echo "--- 进程数=1, OpenMP=1 ---" | tee -a $RESULTS_FILE
export OMP_NUM_THREADS=1
mpirun -np 1 --hostfile $HOSTFILE ./row_dmvp 2>&1 | tee -a $RESULTS_FILE

# 进程数=1-4，使用OpenMP
for np in 1 2 3 4; do
    echo "" | tee -a $RESULTS_FILE
    echo "--- 进程数=$np, OpenMP=2 ---" | tee -a $RESULTS_FILE
    export OMP_NUM_THREADS=2
    mpirun -np $np --hostfile $HOSTFILE ./row_dmvp 2>&1 | tee -a $RESULTS_FILE
done

echo "" | tee -a $RESULTS_FILE
echo "=========================================" | tee -a $RESULTS_FILE
echo "按列并行实验" | tee -a $RESULTS_FILE
echo "=========================================" | tee -a $RESULTS_FILE

# 进程数=1，不使用OpenMP
echo "" | tee -a $RESULTS_FILE
echo "--- 进程数=1, OpenMP=1 ---" | tee -a $RESULTS_FILE
export OMP_NUM_THREADS=1
mpirun -np 1 --hostfile $HOSTFILE ./col_dmvp 2>&1 | tee -a $RESULTS_FILE

# 进程数=1-4，使用OpenMP
for np in 1 2 3 4; do
    echo "" | tee -a $RESULTS_FILE
    echo "--- 进程数=$np, OpenMP=2 ---" | tee -a $RESULTS_FILE
    export OMP_NUM_THREADS=2
    mpirun -np $np --hostfile $HOSTFILE ./col_dmvp 2>&1 | tee -a $RESULTS_FILE
done

echo "" | tee -a $RESULTS_FILE
echo "=========================================" | tee -a $RESULTS_FILE
echo "实验完成！结果已保存到 $RESULTS_FILE" | tee -a $RESULTS_FILE
echo "=========================================" | tee -a $RESULTS_FILE
