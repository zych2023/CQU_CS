# PageRank 并行算法 — 《并行与分布式计算》课程项目

## 项目概述

本项目实现了 PageRank 算法的串行版本、OpenMP 并行版本和 MPI 并行版本，
并在不同图规模和并行配置下进行了系统的性能测试与分析。

### 选题信息
- **题目**：题目4 — PageRank 算法的并行化
- **小组成员**：（请填写）
- **完成日期**：2026年5月

---

## 目录结构

```
fbs_project/
├── README.md                           # 本文件
├── Makefile                            # 构建系统
├── src/
│   ├── utils.h                         # 公共工具库（图结构、计时、I/O）
│   ├── graph_generator.cpp             # 图数据生成器
│   ├── pagerank_serial.cpp             # 任务1：串行 PageRank
│   ├── pagerank_openmp.cpp             # 任务2：OpenMP 并行 PageRank
│   └── pagerank_mpi.cpp                # 任务3：MPI 并行 PageRank
├── scripts/
│   ├── setup_huawei.sh                 # 华为云环境配置脚本
│   ├── run_all_experiments.sh          # 全量实验运行脚本
│   ├── run_mpi_multinode.sh            # 多节点 MPI 实验脚本
│   └── analyze_results.py              # 实验结果分析与可视化
├── data/                               # 图数据文件（自动生成）
│   ├── graph_1K.txt
│   ├── graph_5K.txt
│   ├── graph_10K.txt
│   ├── graph_50K.txt
│   └── graph_100K.txt
└── results/                            # 实验结果
    ├── serial_*.txt                    # 串行 PR 值
    ├── openmp_*.txt                    # OpenMP PR 值
    ├── mpi_*.txt                       # MPI PR 值
    ├── experiment_results.csv          # 汇总 CSV
    ├── analysis_summary.txt            # 文字分析摘要
    └── plots/                          # 可视化图表
        ├── speedup.png                 # 加速比曲线
        ├── efficiency.png              # 并行效率曲线
        ├── runtime_comparison.png      # 运行时间对比
        └── scaling.png                 # 可扩展性分析
```

---

## 快速开始

### 1. 环境要求

| 组件 | 最低版本 | 说明 |
|------|---------|------|
| g++ | 7.0+ | 支持 C++17 |
| OpenMP | 3.0+ | g++ 自带（需 libgomp） |
| MPI | OpenMPI 4.0+ 或 MPICH 3.0+ | 分布式版本需要 |
| Python | 3.8+ | 仅分析脚本需要 |
| matplotlib | 3.0+ | 仅绘图需要 |
| pandas | 1.0+ | 仅数据分析需要 |

### 2. 编译

```bash
# 编译所有目标
make all

# 仅编译某个版本
make serial
make openmp
make mpi
```

### 3. 生成测试数据

```bash
make generate
# 或直接运行
./bin/graph_generator
```

### 4. 运行实验

```bash
# 串行实验（批量所有图规模）
make run_serial

# OpenMP 实验（指定图文件）
OMP_NUM_THREADS=4 ./bin/pagerank_openmp data/graph_10K.txt

# MPI 实验（4进程）
mpirun -np 4 ./bin/pagerank_mpi data/graph_10K.txt

# 全量实验（需要所有环境就绪）
./scripts/run_all_experiments.sh
```

### 5. 分析结果

```bash
pip install matplotlib pandas
python scripts/analyze_results.py
```

---

## 算法设计说明

### 1. 图数据结构

采用 **CSR (Compressed Sparse Row)** 格式存储图：
- `row_ptr[i]` : 节点 i 的出边在 `col_idx` 中的起始位置
- `col_idx[k]` : 第 k 条边的目标节点编号
- `out_degree[i]` : 节点 i 的出度

CSR 格式的优势：
- 内存紧凑，cache 友好
- 遍历某节点的所有出边是连续内存访问
- 适合稀疏图（网页图通常是稀疏的）

### 2. 串行算法

- 幂迭代法（Power Iteration）
- 阻尼因子 d = 0.85
- 悬挂节点（出度为0）的 PR 值均匀分配给所有节点
- 收敛判定：L1 残差 < 1e-6
- 使用入边列表优化，避免 O(N²) 扫描

### 3. OpenMP 并行策略

- **节点级并行**：将 N 个节点的 PR 计算分配给多个线程
- `#pragma omp parallel for schedule(dynamic, 64)` 动态调度
- 悬挂节点贡献使用 `reduction(+:dangling_sum)` 归约
- 残差计算使用 `reduction(+:diff)` 归约
- 每轮迭代隐式 barrier 同步

### 4. MPI 并行策略

- **图划分**：按节点 ID 均匀划分，每个进程负责 `N/P` 个节点
- **通信**：每轮使用 `MPI_Allgatherv` 收集所有进程的新 PR 值
- **悬挂节点**：`MPI_Allreduce` 全局求和
- **收敛判定**：`MPI_Allreduce` 全局残差

### 5. 正确性验证

- 并行结果与串行基准对比 L1/L2 范数差异
- PR 值总和应 ≈ 1.0
- 不同并行配置的结果应一致（数值精度内）

---

## 华为云部署指南

### Step 1: 购买 ECS 服务器

1. 登录 [华为云控制台](https://console.huaweicloud.com/)
2. 进入 **弹性云服务器 ECS** → **购买**
3. 推荐配置：
   - **规格**：c6.xlarge.2（4核8G）或更高
   - **镜像**：Ubuntu 22.04
   - **存储**：40G SSD
   - **网络**：选择同一 VPC 和子网（便于 MPI 通信）
   - **安全组**：放通 22 端口（SSH）和 MPI 使用的端口范围
4. 购买 2~4 台实例（用于 MPI 多节点实验）
5. 设置 SSH 密钥对，下载私钥文件

### Step 2: 配置 SSH 免密登录

直接云服务器生成了,此步略过.
```bash
# 在本机生成密钥（如果没有）
ssh-keygen -t rsa -b 4096

# 将公钥复制到每台服务器
ssh-copy-id -i ~/.ssh/id_rsa.pub user@<server_ip>

# 测试免密登录
ssh user@<server_ip> "hostname"
```

### Step 3: 上传项目代码

```bash
# 上传到所有服务器
for ip in <ip1> <ip2> <ip3> <ip4>; do
    scp -r fbs_project/ user@${ip}:~/
done
```

### Step 4: 环境配置

```bash
# SSH 登录服务器
ssh user@<server_ip>

# 执行环境配置脚本
cd ~/fbs_project
chmod +x scripts/setup_huawei.sh
./scripts/setup_huawei.sh
```

### Step 5: 运行实验

```bash
# 单机实验（OpenMP）
./scripts/run_all_experiments.sh

# 多节点实验（MPI）
# 1. 编辑 scripts/run_mpi_multinode.sh 中的 NODES 数组
# 2. 执行
chmod +x scripts/run_mpi_multinode.sh
./scripts/run_mpi_multinode.sh
```

### Step 6: 下载结果

```bash
# 在本机执行
scp -r user@<server_ip>:~/fbs_project/results/ ./results/
```

---

## 实验结果

### 实验环境

| 项目 | 配置 |
|------|------|
| 云平台 | 华为云 ECS |
| 服务器数量 | 4 台 |
| 规格 | c6.xlarge.2（4核 8GB） |
| 操作系统 | Ubuntu 22.04 LTS |
| 编译器 | g++ 11.4.0 |
| OpenMP | 3.0+（g++ 内置） |
| MPI | OpenMPI 4.1.2 |
| 网络 | 同 VPC 内网（172.16.0.x） |

### 任务1：串行 PageRank

| 图规模 | 节点数 | 边数 | 迭代次数 | 运行时间(ms) |
|--------|--------|------|---------|-------------|
| 1K     | 1,000  | 10,000   | 11    | 0.21        |
| 5K     | 5,000  | 50,000   | 11    | 1.11        |
| 10K    | 10,000 | 100,000  | 11    | 2.52        |
| 50K    | 50,000 | 500,000  | 11    | 16.32       |
| 100K   | 100,000| 1,000,000| 11    | 41.34       |

> 所有图规模均在 11 次迭代内收敛（L1 残差 < 1e-6），PR 值总和 = 1.0。
> 运行时间与图规模（边数）近似线性增长，符合 CSR 格式下 O(E) 的算法复杂度。

### 任务2：OpenMP 并行

#### 实验数据

| 图规模 | 1线程(ms) | 2线程(ms) | 4线程(ms) | 2线程加速比 | 4线程加速比 | 4线程效率 |
|--------|----------|----------|----------|------------|------------|----------|
| 1K     | 0.22     | 0.15     | 0.12     | 1.47x      | 1.83x      | 45.8%    |
| 5K     | 1.12     | 0.65     | 0.40     | 1.72x      | 2.80x      | 70.0%    |
| 10K    | 2.55     | 1.42     | 0.78     | 1.80x      | 3.27x      | 81.7%    |
| 50K    | 16.50    | 8.95     | 4.82     | 1.84x      | 3.42x      | 85.6%    |
| 100K   | 42.12    | 24.28    | 12.52    | 1.73x      | 3.36x      | 84.1%    |

#### 加速比曲线

![加速比曲线](results/plots/speedup.png)

#### 并行效率曲线

![并行效率曲线](results/plots/efficiency.png)

#### 分析

1. **加速比**：4 线程时最高加速比达到 **3.42x**（50K 节点图），接近理论上限 4x。
2. **并行效率**：大规模图（10K+）的并行效率稳定在 **81%-86%**，表明 OpenMP 并行化效果良好。
3. **小图限制**：1K 节点图的效率仅 45.8%，原因是计算量小，线程创建和同步开销占比大。
4. **调度策略**：采用 `schedule(dynamic, 64)` 动态调度，有效平衡了各线程负载。

### 任务3：MPI 多节点并行

#### 实验数据

| 图规模 | 1进程(ms) | 2进程(ms) | 4进程(ms) | 2进程加速比 | 4进程加速比 | 4进程效率 |
|--------|----------|----------|----------|------------|------------|----------|
| 1K     | 0.35     | 5.20     | 8.50     | 0.07x      | 0.04x      | 1.0%     |
| 5K     | 1.80     | 8.30     | 12.10    | 0.22x      | 0.15x      | 3.7%     |
| 10K    | 3.50     | 15.80    | 22.40    | 0.22x      | 0.16x      | 3.9%     |
| 50K    | 25.50    | 55.20    | 98.30    | 0.46x      | 0.26x      | 6.5%     |
| 100K   | 426.84   | 287.71   | 412.19   | 1.48x      | 1.04x      | 25.9%    |

#### 运行时间对比

![运行时间对比](results/plots/runtime_comparison.png)

#### 可扩展性分析

![可扩展性分析](results/plots/scaling.png)

#### 分析

1. **通信开销主导**：小规模图（< 50K）的 MPI 加速比远低于 1.0，说明 `MPI_Allgatherv` 通信开销远大于计算收益。
2. **大图改善**：100K 节点图在 2 进程时达到 **1.48x** 加速，但 4 进程时反而下降至 1.04x，表明通信开销随进程数增加而急剧增长。
3. **网络瓶颈**：跨节点通信通过内网（172.16.0.x），虽然在同一 VPC，但延迟和带宽仍远低于共享内存。
4. **单进程异常**：MPI 单进程运行时间（426.84ms）远大于串行版本（41.34ms），原因是 MPI 框架初始化和图数据广播的额外开销。

### 任务4：性能分析与对比

#### 综合对比图

![综合对比](results/plots/runtime_comparison.png)

#### OpenMP vs MPI 对比

| 对比维度 | OpenMP | MPI |
|---------|--------|-----|
| 通信方式 | 共享内存 | 网络消息传递 |
| 最佳加速比 | 3.42x（4线程） | 1.48x（2进程） |
| 最佳效率 | 85.6% | 25.9% |
| 适用场景 | 单机多核 | 跨节点大规模并行 |
| 编程复杂度 | 低（编译制导） | 高（显式通信） |

#### 加速比不理想的原因分析

**OpenMP 方面：**
- 小图计算量不足，线程开销占比大
- 存在隐式 barrier 同步，限制了并行度
- 动态调度本身有一定开销

**MPI 方面：**
- `MPI_Allgatherv` 每轮迭代需全局通信，延迟高
- 图划分不均匀导致负载不均衡
- 网络带宽和延迟限制了扩展性
- MPI 框架初始化开销显著

#### 改进方向

1. **MPI 优化**：采用非阻塞通信（`MPI_Iallgatherv`）重叠计算与通信
2. **图划分优化**：使用 METIS 等工具进行负载均衡的图划分
3. **混合并行**：节点内 OpenMP + 节点间 MPI（MPI+OpenMP 混合模式）
4. **更大规模**：测试百万级节点图，使计算/通信比更高

---

## 实验过程中遇到的问题与解决方案

### 问题1：SSH 密钥认证失败

**现象**：使用华为云 `.pem` 密钥文件登录时提示 "Permission denied"

**原因**：
- Windows 上 `.pem` 文件权限过于开放，SSH 拒绝使用
- 华为云默认用户名为 `root` 而非 `ubuntu`

**解决方案**：
```powershell
# 修改密钥文件权限
icacls "key\pagerank-key.pem" /inheritance:r
icacls "key\pagerank-key.pem" /grant:r "zuoye:R"

# 使用 root 用户登录
ssh -i key/pagerank-key.pem root@<server_ip>
```

### 问题2：dpkg 锁冲突

**现象**：运行 `setup_huawei.sh` 时提示 "Could not get lock /var/lib/dpkg/lock-frontend"

**原因**：多个 apt 进程同时运行，或上次安装未正常结束

**解决方案**：
```bash
# 终止占用进程
kill -9 <pid>

# 删除锁文件后重新执行
rm -f /var/lib/dpkg/lock-frontend /var/lib/dpkg/lock
dpkg --configure -a
```

### 问题3：MPI root 权限限制

**现象**：`mpirun` 提示 "Running as root is stronglyly discouraged"

**解决方案**：
```bash
mpirun --allow-run-as-root ...
```

### 问题4：MPI 跨节点通信失败

**现象**：MPI 启动后卡住或报 "Host key verification failed"

**原因**：
- 节点间 SSH 未配置免密登录
- SSH StrictHostKeyChecking 阻止连接

**解决方案**：
1. 在所有节点间配置 SSH 免密登录
2. 修改 `/etc/ssh/ssh_config`：添加 `StrictHostKeyChecking no`
3. 使用内网 IP 而非公网 IP 配置 hostfile

### 问题5：MPI 远程节点找不到可执行文件

**现象**：报 "could not access or execute an executable"

**原因**：MPI 在远程节点执行时工作目录不同

**解决方案**：使用绝对路径
```bash
mpirun --hostfile hostfile -np 4 /root/fbs_project/bin/pagerank_mpi /root/fbs_project/data/graph_10K.txt
```

---

## 总结

本项目成功实现了 PageRank 算法的串行、OpenMP 和 MPI 三种版本，并在华为云 4 核服务器上进行了系统测试：

1. **串行版本**：CSR 格式 + 入边列表优化，100K 节点图仅需 41ms
2. **OpenMP**：4 线程达到 3.42x 加速，效率 85.6%，适合单机并行
3. **MPI**：受通信开销限制，最佳仅 1.48x 加速，适合更大规模场景

实验结果表明，对于稀疏图的 PageRank 计算，**共享内存并行（OpenMP）显著优于消息传递并行（MPI）**，主要原因是 MPI 的全局通信开销（Allgatherv）在小规模场景下抵消了并行收益。未来可通过 MPI+OpenMP 混合并行、非阻塞通信、图划分优化等手段提升 MPI 性能。

---

## 常见问题

### Q: 编译 OpenMP 版本报错 "omp.h not found"
A: 安装 libgomp：`sudo apt-get install libgomp1`（Ubuntu）

### Q: mpirun 报错 "orted not found"
A: 添加 MPI 到 PATH：`export PATH=/usr/lib64/openmpi/bin:$PATH`

### Q: 本机没有 MPI 环境怎么办
A: 所有并行实验都需要在华为云服务器上运行。串行版本可以在本机编译测试。

### Q: 如何修改图规模
A: 编辑 `src/graph_generator.cpp` 中的 `specs` 数组，然后重新编译运行。

---

## 参考文献

1. Brin, S., & Page, L. (1998). The anatomy of a large-scale hypertextual web search engine.
2. Page, L., et al. (1999). The PageRank citation ranking: Bringing order to the web.
3. OpenMP Application Program Interface, Version 5.0.
4. MPI: A Message-Passing Interface Standard, Version 3.1.
