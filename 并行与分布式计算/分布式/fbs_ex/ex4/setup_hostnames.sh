#!/bin/bash
# 配置主机名和hosts文件
# 在所有节点上执行

echo "配置主机名和hosts文件..."

# 设置主机名
if [ "$1" == "node1" ]; then
    hostnamectl set-hostname node1
elif [ "$1" == "node2" ]; then
    hostnamectl set-hostname node2
elif [ "$1" == "node3" ]; then
    hostnamectl set-hostname node3
elif [ "$1" == "node4" ]; then
    hostnamectl set-hostname node4
fi

# 配置hosts
cat >> /etc/hosts << EOF
121.36.20.246   node1
113.44.236.184  node2
1.94.234.116    node3
114.116.247.207 node4
EOF

echo "主机名配置完成: $(hostname)"
cat /etc/hosts
