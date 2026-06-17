# 实验二：基于OpenMP的快速排序实验

---

## 三、实验过程或算法（源程序）

### 3.1 实验环境搭建与目录创建

本次实验在华为鲲鹏云服务器上进行。以 `zhangsan` 用户登录后，首先创建用于存放实验文件的目录，并进入该目录：

```bash
mkdir /home/zhangsan/quicksort
cd /home/zhangsan/quicksort
```

### 3.2 快速排序算法源码（quick_sort.cpp）

在 `quicksort` 目录下创建 `quick_sort.cpp` 文件，内容如下：

```cpp
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <time.h>

#include <iostream>

#include "omp.h"

using namespace std;

void QuickSort(int *&array, int len) {
    if (len <= 1) return;
    int pivot = array[len / 2];
    int left_ptr = 0;
    int right_ptr = len - 1;
    while (left_ptr <= right_ptr) {
        while (array[left_ptr] < pivot) left_ptr += 1;
        while (array[right_ptr] > pivot) right_ptr -= 1;
        if (left_ptr <= right_ptr) {
            swap(array[left_ptr], array[right_ptr]);
            left_ptr += 1;
            right_ptr -= 1;
        }
    }
    int *sub_array[] = {array, &(array[left_ptr])};
    int sub_len[] = {right_ptr + 1, len - left_ptr};

#pragma omp task default(none) firstprivate(sub_array, sub_len)
    { QuickSort(sub_array[0], sub_len[0]); }
#pragma omp task default(none) firstprivate(sub_array, sub_len)
    { QuickSort(sub_array[1], sub_len[1]); }
    // for (int i = 0; i < 2; i++) QuickSort(sub_array[i], sub_len[i]);
}

int main(int argc, char *argv[]) {
    srand(time(NULL));
    if (argc != 3) {
        cout << "Usage: " << argv[0] << " thread-num array-len\n";
        exit(-1);
    }
    int t = atoi(argv[1]);
    int n = atoi(argv[2]);
    int *array = new int[n];
    omp_set_num_threads(t);

    unsigned int seed = 1024;
#pragma omp parallel for
    for (int i = 0; i < n; i++) array[i] = rand_r(&seed);

    struct timeval start, stop;
    gettimeofday(&start, NULL);

#pragma omp parallel default(none) shared(array, n)
    {
#pragma omp single nowait
        { QuickSort(array, n); }
    }
    gettimeofday(&stop, NULL);

    double elapse = (stop.tv_sec - start.tv_sec) * 1000 +
                    (stop.tv_usec - start.tv_usec) / 1000;
    cout << elapse << " " << n << endl;

    for (int i = 0; i < n - 1; i++) {
        if (array[i] > array[i + 1]) {
            cerr << "quick sort fails! \n";
            break;
        }
    }
    return 0;
}
```

#### 算法说明：

1. **快速排序主体函数 `QuickSort`**：采用经典的“双指针+基准值”原地分区策略。以数组中间元素 `array[len / 2]` 作为 pivot，通过左右指针向中间扫描并交换逆序元素，最终将数组划分为不大于 pivot 和不大于 pivot 的两部分。分区完成后，递归地对左右两个子数组进行排序。

2. **OpenMP 任务并行**：在 `QuickSort` 函数中，对左右两个子数组的递归调用前分别使用 `#pragma omp task` 制导语句，将两个递归排序任务提交到 OpenMP 任务队列中。`default(none)` 强制要求显式声明所有变量的数据属性，`firstprivate(sub_array, sub_len)` 确保每个任务拥有子数组指针和长度的私有副本，避免数据竞争。

3. **主函数并行控制**：`main` 函数中首先通过 `omp_set_num_threads(t)` 设置线程数为命令行参数指定的值。随后使用 `#pragma omp parallel` 创建并行区域，在该区域内通过 `#pragma omp single nowait` 仅由一个线程启动初始的 `QuickSort` 调用，避免重复排序；其余线程则从任务队列中领取并执行 `task`，实现工作窃取式的动态负载均衡。

4. **数据生成**：通过 `#pragma omp parallel for` 并行生成包含 `n` 个随机整数的测试数组，使用 `rand_r(&seed)` 保证线程安全。

5. **结果校验**：排序完成后，程序遍历数组检查是否满足升序，若发现逆序则输出错误提示，确保算法正确性。

### 3.3 Makefile 的编写

创建 `Makefile` 文件，用于自动管理编译依赖：

```makefile
CC = g++
CCFLAGS = -I . -O2 -fopenmp
LDFLAGS = # -lopenblas

all:  quicksort

quicksort: quick_sort.cpp
	${CC} ${CCFLAGS} quick_sort.cpp -o quicksort ${LDFLAGS}

clean:
	rm  quicksort
```

其中 `-fopenmp` 选项指示编译器启用 OpenMP 支持，`-O2` 开启二级优化以提高程序性能。

### 3.4 编译程序

在终端执行 `make` 命令完成编译：

```bash
make
```

编译成功后生成可执行文件 `quicksort`。

### 3.5 运行脚本与测试方法

为了系统地比较不同线程数下的性能，编写 `run.sh` 脚本，固定测试数据规模为 8,000,000：

```bash
app=${1}

if [ ${app} = "quicksort" ]; then
	./quicksort ${2} 8000000
fi
```

分别执行以下命令，测试线程数从 1 到 8 的运行结果：

```bash
bash run.sh quicksort 1
bash run.sh quicksort 2
bash run.sh quicksort 3
bash run.sh quicksort 4
bash run.sh quicksort 5
bash run.sh quicksort 6
bash run.sh quicksort 7
bash run.sh quicksort 8
```

---

## 四、实验结果及分析和（或）源程序调试过程

### 4.1 实验运行结果与加速比计算

为全面验证 OpenMP 并行快速排序的加速特性，本实验分别在华为鲲鹏云服务器（2 核）和本地 PC（AMD Ryzen 7 5800H，8 核 16 线程，WSL2 环境）上运行相同程序，测试数据规模均为 8,000,000 个整数。加速比统一按公式 $S = T_1 / T_n$ 计算。

#### 4.1.1 华为鲲鹏云服务器（2 核）

| 线程数 | 运行时间 (ms) | 加速比 |
|--------|--------------|--------|
| 1      | 1149         | 1.00   |
| 2      | 584          | 1.97   |
| 3      | 583          | 1.97   |
| 4      | 588          | 1.95   |
| 5      | 595          | 1.93   |
| 6      | 580          | 1.98   |
| 7      | 573          | 2.00   |
| 8      | 585          | 1.96   |

#### 4.1.2 本地 PC 补充实验（8 核 16 线程，WSL2）

通过 `lscpu` 确认本地处理器为 AMD Ryzen 7 5800H，具备 8 个物理核心、16 个逻辑线程（SMT 超线程）。在同一套源码与相同数据规模下测得：

| 线程数 | 运行时间 (ms) | 加速比 |
|--------|--------------|--------|
| 1      | 1231         | 1.00   |
| 2      | 956          | 1.29   |
| 3      | 663          | 1.86   |
| 4      | 507          | 2.43   |
| 5      | 429          | 2.87   |
| 6      | 407          | 3.02   |
| 7      | 367          | 3.35   |
| 8      | 365          | 3.37   |

### 4.2 结果分析

#### （1）云服务器环境（2 核）：加速比在 2 线程处饱和

当线程数从 1 增加到 2 时，运行时间从 **1149 ms** 降至 **584 ms**，加速比约 **1.97**，接近理想的 2 倍。这是因为云服务器配备 2 核 CPU，双线程可映射到两个独立物理核心上真正并行执行。

当线程数从 2 继续增加到 8 时，运行时间始终维持在 **573~595 ms** 区间，加速比稳定在 **1.93~2.00** 之间，不再提升。原因如下：

- **物理核心资源已耗尽**：2 核环境下，超过 2 个线程后无法获得真实并行执行单元，仅能通过时间片轮转共享 2 个核心。
- **调度开销增加**：过多的线程导致 OpenMP 运行时和操作系统频繁进行线程切换与任务调度，引入额外开销。
- **符合 Amdahl 定律**：快速排序中存在不可并行的串行部分（如分区控制逻辑、任务创建同步），加速比存在上限。

#### （2）本地 PC 环境（8 核 16 线程）：加速比持续增长但边际递减

本地 PC 在 WSL2 环境中运行相同测试，加速比随线程数增加呈现持续增长但增速明显放缓的趋势：

- **1→2 线程**：加速比仅 **1.29**，未达 2 倍。由于 5800H 支持 SMT（同步多线程），2 个线程可能被调度到同一物理核心的 2 个逻辑线程上，共享执行单元；同时 WSL2 虚拟化层也带来一定调度开销。
- **2→4 线程**：加速比从 1.29 提升至 **2.43**，增长显著。此时开始利用独立的物理核心，真正的并行计算能力得到释放。
- **4→8 线程**：加速比从 2.43 提升至 **3.37**，继续增长但增速放缓。8 线程恰好对应 8 个物理核心（尚未使用超线程的另外 8 个逻辑核心），但受限于：
  - **算法固有串行比例**：快速排序的划分操作是原地串行执行的，每一层递归都存在串行瓶颈；
  - **任务调度开销**：`#pragma omp task` 的创建、入队、窃取和同步随递归层级增加而累积；
  - **内存带宽竞争**：8 个核心同时读写内存，导致缓存行颠簸和内存带宽成为瓶颈；
  - **WSL2 虚拟化开销**：运行在 Windows Hyper-V 上的 Linux 子系统存在额外的虚拟化调度成本。

#### （3）跨环境对比与结论

将两个环境的加速比曲线进行对比，可以观察到明显的差异：

| 对比维度 | 华为云服务器（2 核） | 本地 PC（8 核） |
|---------|-------------------|--------------|
| 最佳线程数 | 2（等于物理核心数） | 8（等于物理核心数） |
| 最高加速比 | ~2.00 | ~3.37 |
| 超配线程表现 | 2→8 线程基本无变化 | 持续增长但边际递减 |
| 主要瓶颈因素 | 物理核心数限制 | 串行比例 + 内存带宽 + 虚拟化 |

两个环境的实验共同验证了以下结论：

1. **加速比的上限由物理核心数和算法串行比例共同决定**。即使本地 PC 拥有 8 个物理核心，由于快速排序的递归串行特性和 OpenMP 任务开销，实际加速比也远低于理想值 8。
2. **线程数应与物理核心数匹配**。云服务器在 2 线程时达到最优，本地 PC 在 8 线程时达到最优（均等于各自物理核心数），继续增加线程无法带来实质收益。
3. **超线程（SMT）对计算密集型任务加速有限**。本地 PC 1→2 线程的加速比仅为 1.29，说明同一物理核心上的两个逻辑线程无法提供接近 2 倍的性能提升。

因此，在实际使用 OpenMP 进行并行优化时，应首先了解目标平台的物理核心数量，将线程数设置为物理核心数或略高（考虑超线程时的微增益），同时通过增大任务粒度、减少同步频率等手段降低并行开销，才能在多核平台上获得理想的加速效果。

---
