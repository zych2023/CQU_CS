# 实验一报告：隐马尔可夫模型中的 Viterbi 算法实现

## 1. 实验题目
隐马尔可夫模型中的 Viterbi 算法实现

## 2. 实验目的
1. 理解隐马尔可夫模型（HMM）的核心组成：隐藏状态、观测序列、初始概率、状态转移概率、发射概率。
2. 掌握 Viterbi 算法的动态规划思想与回溯过程。
3. 能够用代码实现 Viterbi 算法，并对给定观测序列预测最可能的隐藏状态序列。

## 3. 实验环境
- 操作系统：Windows
- 编程语言：Python 3
- 外部依赖：无（未使用任何外部 HMM 库，满足“自编码实现”要求）

## 4. 模型参数与任务说明
### 4.1 隐状态与观测
- 隐状态（天气）：Sunny、Rainy
- 观测（小明行为）：walk、shop、clean

### 4.2 HMM 参数
- 初始概率 $\pi$：
  - $\pi(Sunny)=0.6$
  - $\pi(Rainy)=0.4$

- 转移概率 $A$：
  - $a_{Sunny,Sunny}=0.8,\ a_{Sunny,Rainy}=0.2$
  - $a_{Rainy,Sunny}=0.4,\ a_{Rainy,Rainy}=0.6$

- 发射概率 $B$：
  - Sunny: walk=0.6, shop=0.3, clean=0.1
  - Rainy: walk=0.1, shop=0.4, clean=0.5

### 4.3 待预测观测序列
1. [walk, shop, clean]
2. [clean, shop, shop, walk]
3. [shop, clean, shop, walk]

## 5. Viterbi 算法原理与步骤
设 $\delta_t(i)$ 表示在时刻 $t$ 处于状态 $i$ 的所有路径中，概率最大的那条路径概率。

### 5.1 初始化
$$
\delta_0(i)=\pi_i\cdot b_i(o_0)
$$

### 5.2 递推
$$
\delta_t(j)=\max_i\left[\delta_{t-1}(i)\cdot a_{ij}\right]\cdot b_j(o_t)
$$
并记录最优前驱状态（回溯指针）：
$$
\psi_t(j)=\arg\max_i\left[\delta_{t-1}(i)\cdot a_{ij}\right]
$$

### 5.3 终止与回溯
1. 在最后时刻选择 $\delta_T$ 最大的状态作为终点。
2. 利用 $\psi$ 从后往前回溯得到最优隐藏状态序列。

## 6. 代码实现说明
本实验代码文件：`exp1_viterbi.py`

实现要点：
1. 手写 `viterbi()` 函数，包含初始化、递推、终止、回溯四个阶段。
2. 使用 `delta` 保存每个时刻每个状态的最优概率。
3. 使用 `psi` 保存每个时刻每个状态对应的最优前驱状态。
4. 输出每条观测序列对应的：
   - 最可能天气序列
   - 最优路径概率
   - 每个时刻的 delta 值

## 7. 运行步骤
1. 打开终端并进入实验目录：
   ```powershell
   cd D:\课程\yy_ex
   ```
2. 运行程序：
   ```powershell
   python exp1_viterbi.py
   ```
3. 终端将输出三组序列的预测天气序列与 delta 值。

## 8. 实验结果
### 8.1 序列 1
- 观测序列：[walk, shop, clean]
- 最可能天气序列：['Sunny', 'Sunny', 'Rainy']
- 最优路径概率：0.0086400000
- delta：
  - t=0: Sunny=0.3600000000, Rainy=0.0400000000
  - t=1: Sunny=0.0864000000, Rainy=0.0288000000
  - t=2: Sunny=0.0069120000, Rainy=0.0086400000

### 8.2 序列 2
- 观测序列：[clean, shop, shop, walk]
- 最可能天气序列：['Rainy', 'Sunny', 'Sunny', 'Sunny']
- 最优路径概率：0.0027648000
- delta：
  - t=0: Sunny=0.0600000000, Rainy=0.2000000000
  - t=1: Sunny=0.0240000000, Rainy=0.0480000000
  - t=2: Sunny=0.0057600000, Rainy=0.0115200000
  - t=3: Sunny=0.0027648000, Rainy=0.0006912000

### 8.3 序列 3
- 观测序列：[shop, clean, shop, walk]
- 最可能天气序列：['Rainy', 'Rainy', 'Sunny', 'Sunny']
- 最优路径概率：0.0027648000
- delta：
  - t=0: Sunny=0.1800000000, Rainy=0.1600000000
  - t=1: Sunny=0.0144000000, Rainy=0.0480000000
  - t=2: Sunny=0.0057600000, Rainy=0.0115200000
  - t=3: Sunny=0.0027648000, Rainy=0.0006912000

## 9. 结果分析
1. 序列 1 以 walk 开始，初始更偏向 Sunny；到 clean 时，Rainy 的发射概率较高，最终路径落在 Rainy。
2. 序列 2 以 clean 开始，Rainy 的发射概率明显更高，后续通过转移与发射综合作用，最终路径转向并保持 Sunny。
3. 序列 3 中 clean 对 Rainy 有明显支持，后续在 walk 时 Sunny 的发射概率更高，因此末尾回到 Sunny。

## 10. 结论
本实验完成了 Viterbi 算法的手工编码实现，能够对给定观测序列输出最可能天气序列与逐时刻 delta 值，满足实验要求。通过实验验证，动态规划与回溯机制能够有效求解 HMM 最优隐藏状态路径问题。

## 11. 截图说明（提交前补充）
请在最终提交版本中补充以下截图：
1. 运行 `python exp1_viterbi.py` 的终端输出截图。
2. 代码关键部分截图（`viterbi` 递推与回溯部分）。
