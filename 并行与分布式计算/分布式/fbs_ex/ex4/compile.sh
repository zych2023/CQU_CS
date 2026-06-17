#!/bin/bash
# 编译脚本
# 用法: bash compile.sh

echo "========================================="
echo "编译DMV程序"
echo "========================================="

# 编译按行并行版本
echo "编译 row_dmvp..."
mpicxx -fopenmp -o row_dmvp row.cpp
if [ $? -eq 0 ]; then
    echo "✅ row_dmvp 编译成功"
else
    echo "❌ row_dmvp 编译失败"
    exit 1
fi

# 编译按列并行版本
echo "编译 col_dmvp..."
mpicxx -fopenmp -o col_dmvp column.cpp
if [ $? -eq 0 ]; then
    echo "✅ col_dmvp 编译成功"
else
    echo "❌ col_dmvp 编译失败"
    exit 1
fi

echo ""
echo "========================================="
echo "编译完成！"
echo "========================================="
echo "生成的可执行文件："
ls -lh row_dmvp col_dmvp
