#!/bin/bash
# 课程项目打包脚本
# 用于整理提交内容到 fbs_project_submit 目录

SUBMIT_DIR="D:/Desktop/fbs_project_submit"
PROJECT_DIR="D:/Desktop/fbs_project"

echo "=========================================="
echo "  PageRank 并行算法 - 课程项目打包"
echo "=========================================="

# 清空提交目录
rm -rf "${SUBMIT_DIR:?}"/*
mkdir -p "$SUBMIT_DIR"

# 1. 复制课程报告
echo "[1/5] 复制课程报告..."
mkdir -p "$SUBMIT_DIR/doc"
cp "$PROJECT_DIR/doc/并行与分布式课程报告.docx" "$SUBMIT_DIR/doc/"

# 2. 复制程序代码
echo "[2/5] 复制程序代码..."
mkdir -p "$SUBMIT_DIR/src"
cp "$PROJECT_DIR/src/"*.cpp "$SUBMIT_DIR/src/"
cp "$PROJECT_DIR/src/"*.h "$SUBMIT_DIR/src/"

# 3. 复制构建和运行配置
echo "[3/5] 复制构建和运行配置..."
cp "$PROJECT_DIR/Makefile" "$SUBMIT_DIR/"
cp "$PROJECT_DIR/README.md" "$SUBMIT_DIR/"
mkdir -p "$SUBMIT_DIR/scripts"
cp "$PROJECT_DIR/scripts/"*.sh "$SUBMIT_DIR/scripts/"
cp "$PROJECT_DIR/scripts/"*.py "$SUBMIT_DIR/scripts/"

# 4. 复制数据集
echo "[4/5] 复制数据集..."
mkdir -p "$SUBMIT_DIR/data"
cp "$PROJECT_DIR/data/"*.txt "$SUBMIT_DIR/data/"

# 5. 复制媒体资源（可视化图表）
echo "[5/5] 复制媒体资源..."
mkdir -p "$SUBMIT_DIR/results/plots"
cp "$PROJECT_DIR/results/plots/"*.png "$SUBMIT_DIR/results/plots/"

# 统计文件
echo ""
echo "=========================================="
echo "  打包完成！"
echo "=========================================="
echo ""
echo "提交目录结构："
cd "$SUBMIT_DIR"
find . -type f | sort | head -20
echo ""
echo "文件统计："
find . -type f | wc -l | xargs echo "  总文件数："
du -sh . | cut -f1 | xargs echo "  总大小："
