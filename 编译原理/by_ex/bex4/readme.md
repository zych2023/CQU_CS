请你根据实验指导书完成实验四。我已完成了第一步实验环境准备。你来完成:

实验 0（引导）：环境与基线（O0/O1/O2/O3 + 生成汇编验证优化发生）
实验 1（自动并行化）：自动向量化（SIMD/NEON）+ OpenMP 并行 for
实验 2（内存布局优化）：struct-peel（重点验证 
calloc 调用与代码生成变化）
实验 3（PGO）：插桩 → 运行采样 → 合并 profile → 反馈编译（对比汇编/布局）
实验 4（Autotuner）：CoreMark 调优全流程（generate → iterate → finalize）
实验 5（综合循环体优化）：Loop Fusion / Strength Reduction ，含汇编验证与Autotuner 对比

注意因为最后需要完成一份实验报告，你需要留意实验要求:
 三类证据必须保留（每个实验都要） 
1. 运行输出：stdout/stderr，含 checksum / 关键指标  
2. 计时数据：使用 
time -p 或程序自带计时（至少跑 3 次取中位数）  
3. 代码生成证据（二选一，推荐汇编）：
生成汇编：
clang -O2 -S -o prog_O2.s prog.c
反汇编：
objdump -d prog_O2 > prog_O2.dump
注意：Docker/WSL2 下 
perf 往往不可用或意义不大（容器没有内核权限/事件源），本课程不要
求 perf。
3.2 计时建议（尽量稳定） 
每个版本至少跑 3 次，记录中位数
OpenMP 程序使用 
omp_get_wtime() ，不要用 
如果主机较弱，优先降低样例规

为了最后我好统计，请你把这几个小实验的验证证据单独整理成一个md，便于我最后的实现