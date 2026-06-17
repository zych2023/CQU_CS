import matplotlib.pyplot as plt
import numpy as np

# 设置中文字体
plt.rcParams['font.sans-serif'] = ['SimHei', 'Microsoft YaHei', 'DejaVu Sans']
plt.rcParams['axes.unicode_minus'] = False

# 实验数据
threads = [1, 2, 3, 4, 5, 6]  # 总线程数 = MPI进程数 × OpenMP线程数

# 按行并行数据
row_times = [5.92892, 5.81732, 5.49982*2, 4.77675*2, 4.66993*2, 4.66993*2]  # 转换为总线程时间
# 实际运行时间（直接使用实验数据）
row_times_actual = [5.92892, 5.81732, 5.49982, 4.77675, 4.66993]

# 按列并行数据
col_times_actual = [42.0965, 41.2201, 32.0817, 24.3486, 23.1365]

# X轴标签
x_labels = ['1进程\n1线程', '1进程\n2线程', '2进程\n2线程', '3进程\n2线程', '4进程\n2线程']
x_pos = np.arange(len(x_labels))

# 创建图表
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 6))

# 按行并行折线图
ax1.plot(x_pos, row_times_actual, 'bo-', linewidth=2, markersize=8, label='按行并行')
ax1.set_xlabel('进程数 × 线程数', fontsize=12)
ax1.set_ylabel('运行时间 (秒)', fontsize=12)
ax1.set_title('按行并行 - 运行时间', fontsize=14, fontweight='bold')
ax1.set_xticks(x_pos)
ax1.set_xticklabels(x_labels, fontsize=10)
ax1.grid(True, linestyle='--', alpha=0.7)
ax1.legend(fontsize=11)

# 添加数据标签
for i, (x, y) in enumerate(zip(x_pos, row_times_actual)):
    ax1.annotate(f'{y:.2f}s', (x, y), textcoords="offset points",
                 xytext=(0, 10), ha='center', fontsize=10)

# 按列并行折线图
ax2.plot(x_pos, col_times_actual, 'rs-', linewidth=2, markersize=8, label='按列并行')
ax2.set_xlabel('进程数 × 线程数', fontsize=12)
ax2.set_ylabel('运行时间 (秒)', fontsize=12)
ax2.set_title('按列并行 - 运行时间', fontsize=14, fontweight='bold')
ax2.set_xticks(x_pos)
ax2.set_xticklabels(x_labels, fontsize=10)
ax2.grid(True, linestyle='--', alpha=0.7)
ax2.legend(fontsize=11)

# 添加数据标签
for i, (x, y) in enumerate(zip(x_pos, col_times_actual)):
    ax2.annotate(f'{y:.2f}s', (x, y), textcoords="offset points",
                 xytext=(0, 10), ha='center', fontsize=10)

plt.tight_layout()
plt.savefig('D:/Desktop/ex4/experiment_results.png', dpi=300, bbox_inches='tight')
plt.show()

print("图表已保存到: D:/Desktop/ex4/experiment_results.png")
