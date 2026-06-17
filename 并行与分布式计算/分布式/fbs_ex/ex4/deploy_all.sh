#!/bin/bash
# 批量部署脚本
# 用法: bash deploy_all.sh

NODES=(
    "121.36.20.246"
    "113.44.236.184"
    "1.94.234.116"
    "114.116.247.207"
)
NAMES=("node1" "node2" "node3" "node4")

echo "========================================="
echo "批量部署到4台服务器"
echo "========================================="

# 配置每台服务器
for i in "${!NODES[@]}"; do
    IP="${NODES[$i]}"
    NAME="${NAMES[$i]}"
    echo ""
    echo ">>> 配置 $NAME ($IP)..."

    # 复制配置脚本
    scp -o StrictHostKeyChecking=no setup_node.sh root@$IP:/root/

    # 执行配置
    ssh -o StrictHostKeyChecking=no root@$IP "bash /root/setup_node.sh"

    if [ $? -eq 0 ]; then
        echo "✅ $NAME 配置完成"
    else
        echo "❌ $NAME 配置失败"
    fi
done

echo ""
echo "========================================="
echo "所有节点配置完成！"
echo "========================================="
