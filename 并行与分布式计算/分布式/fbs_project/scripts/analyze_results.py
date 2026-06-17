"""
analyze_results.py - PageRank 实验结果分析与可视化
=====================================================
用法：
    python scripts/analyze_results.py

功能：
    1. 读取实验结果 CSV
    2. 绘制加速比曲线（Speedup vs. Threads/Processes）
    3. 绘制并行效率曲线（Efficiency vs. Threads/Processes）
    4. 绘制不同图规模下的运行时间对比
    5. 输出分析报告摘要

依赖：
    pip install matplotlib pandas numpy
"""

import os
import sys
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
import numpy as np

# 设置中文字体（兼容 Windows / Linux）
matplotlib.rcParams['font.sans-serif'] = ['SimHei', 'DejaVu Sans', 'Arial']
matplotlib.rcParams['axes.unicode_minus'] = False

RESULTS_DIR = "results"
CSV_FILE = os.path.join(RESULTS_DIR, "experiment_results.csv")
PLOT_DIR = os.path.join(RESULTS_DIR, "plots")


def ensure_dirs():
    os.makedirs(PLOT_DIR, exist_ok=True)


def load_data():
    """加载实验结果 CSV"""
    if not os.path.exists(CSV_FILE):
        print(f"Error: {CSV_FILE} not found.")
        print("Please run experiments first: ./scripts/run_all_experiments.sh")
        sys.exit(1)
    df = pd.read_csv(CSV_FILE)
    print(f"Loaded {len(df)} experiment records.")
    print(f"Columns: {list(df.columns)}")
    print(f"Experiments: {df['experiment'].unique()}")
    print()
    return df


def plot_speedup(df):
    """绘制加速比曲线"""
    fig, axes = plt.subplots(1, 2, figsize=(14, 6))

    # OpenMP 加速比
    omp_data = df[df['experiment'] == 'openmp']
    if not omp_data.empty:
        for graph in omp_data['graph'].unique():
            g_data = omp_data[omp_data['graph'] == graph]
            axes[0].plot(g_data['config'], g_data['speedup'],
                        marker='o', label=graph.replace('data/', '').replace('.txt', ''))
        axes[0].plot([1, 16], [1, 16], 'k--', alpha=0.3, label='Ideal')
        axes[0].set_xlabel('Number of Threads')
        axes[0].set_ylabel('Speedup')
        axes[0].set_title('OpenMP Speedup')
        axes[0].legend()
        axes[0].grid(True, alpha=0.3)
        axes[0].set_xticks(sorted(omp_data['config'].unique()))

    # MPI 加速比
    mpi_data = df[df['experiment'] == 'mpi']
    if not mpi_data.empty:
        for graph in mpi_data['graph'].unique():
            g_data = mpi_data[mpi_data['graph'] == graph]
            axes[1].plot(g_data['config'], g_data['speedup'],
                        marker='s', label=graph.replace('data/', '').replace('.txt', ''))
        axes[1].plot([1, 16], [1, 16], 'k--', alpha=0.3, label='Ideal')
        axes[1].set_xlabel('Number of Processes')
        axes[1].set_ylabel('Speedup')
        axes[1].set_title('MPI Speedup')
        axes[1].legend()
        axes[1].grid(True, alpha=0.3)
        axes[1].set_xticks(sorted(mpi_data['config'].unique()))

    plt.tight_layout()
    out_path = os.path.join(PLOT_DIR, "speedup.png")
    plt.savefig(out_path, dpi=150)
    plt.close()
    print(f"Saved: {out_path}")


def plot_efficiency(df):
    """绘制并行效率曲线"""
    fig, axes = plt.subplots(1, 2, figsize=(14, 6))

    # OpenMP 并行效率
    omp_data = df[df['experiment'] == 'openmp']
    if not omp_data.empty:
        for graph in omp_data['graph'].unique():
            g_data = omp_data[omp_data['graph'] == graph]
            axes[0].plot(g_data['config'], g_data['efficiency'],
                        marker='o', label=graph.replace('data/', '').replace('.txt', ''))
        axes[0].axhline(y=1.0, color='k', linestyle='--', alpha=0.3, label='Ideal')
        axes[0].set_xlabel('Number of Threads')
        axes[0].set_ylabel('Parallel Efficiency')
        axes[0].set_title('OpenMP Parallel Efficiency')
        axes[0].legend()
        axes[0].grid(True, alpha=0.3)
        axes[0].set_ylim(0, 1.3)
        axes[0].set_xticks(sorted(omp_data['config'].unique()))

    # MPI 并行效率
    mpi_data = df[df['experiment'] == 'mpi']
    if not mpi_data.empty:
        for graph in mpi_data['graph'].unique():
            g_data = mpi_data[mpi_data['graph'] == graph]
            axes[1].plot(g_data['config'], g_data['efficiency'],
                        marker='s', label=graph.replace('data/', '').replace('.txt', ''))
        axes[1].axhline(y=1.0, color='k', linestyle='--', alpha=0.3, label='Ideal')
        axes[1].set_xlabel('Number of Processes')
        axes[1].set_ylabel('Parallel Efficiency')
        axes[1].set_title('MPI Parallel Efficiency')
        axes[1].legend()
        axes[1].grid(True, alpha=0.3)
        axes[1].set_ylim(0, 1.3)
        axes[1].set_xticks(sorted(mpi_data['config'].unique()))

    plt.tight_layout()
    out_path = os.path.join(PLOT_DIR, "efficiency.png")
    plt.savefig(out_path, dpi=150)
    plt.close()
    print(f"Saved: {out_path}")


def plot_runtime_comparison(df):
    """绘制运行时间对比柱状图"""
    fig, axes = plt.subplots(1, 3, figsize=(18, 6))

    graphs = df['graph'].unique()

    for idx, graph in enumerate(graphs[:3]):
        ax = axes[idx] if idx < 3 else axes[2]
        g_data = df[df['graph'] == graph]

        experiments = []
        times = []
        configs = []

        for _, row in g_data.iterrows():
            experiments.append(row['experiment'])
            times.append(row['time_ms'])
            configs.append(int(row['config']))

        # 按实验类型和配置分组
        serial_time = g_data[g_data['experiment'] == 'serial']['time_ms'].values
        serial_t = serial_time[0] if len(serial_time) > 0 else 0

        omp_data = g_data[g_data['experiment'] == 'openmp'].sort_values('config')
        mpi_data = g_data[g_data['experiment'] == 'mpi'].sort_values('config')

        x_labels = []
        y_values = []
        colors = []

        if serial_t > 0:
            x_labels.append('Serial')
            y_values.append(serial_t)
            colors.append('#2196F3')

        for _, row in omp_data.iterrows():
            x_labels.append(f'OMP-{int(row["config"])}')
            y_values.append(row['time_ms'])
            colors.append('#4CAF50')

        for _, row in mpi_data.iterrows():
            x_labels.append(f'MPI-{int(row["config"])}')
            y_values.append(row['time_ms'])
            colors.append('#FF9800')

        ax.bar(range(len(x_labels)), y_values, color=colors, alpha=0.8)
        ax.set_xticks(range(len(x_labels)))
        ax.set_xticklabels(x_labels, rotation=45, ha='right', fontsize=8)
        ax.set_ylabel('Time (ms)')
        ax.set_title(graph.replace('data/', '').replace('.txt', ''))
        ax.grid(True, alpha=0.3, axis='y')

    plt.tight_layout()
    out_path = os.path.join(PLOT_DIR, "runtime_comparison.png")
    plt.savefig(out_path, dpi=150)
    plt.close()
    print(f"Saved: {out_path}")


def plot_scaling(df):
    """绘制可扩展性分析图（强扩展 vs 弱扩展）"""
    fig, ax = plt.subplots(figsize=(10, 6))

    omp_data = df[df['experiment'] == 'openmp']
    if not omp_data.empty:
        for graph in omp_data['graph'].unique():
            g_data = omp_data[omp_data['graph'] == graph].sort_values('config')
            ax.plot(g_data['config'], g_data['time_ms'],
                   marker='o', label=f"OMP {graph.replace('data/', '').replace('.txt', '')}")

    mpi_data = df[df['experiment'] == 'mpi']
    if not mpi_data.empty:
        for graph in mpi_data['graph'].unique():
            g_data = mpi_data[mpi_data['graph'] == graph].sort_values('config')
            ax.plot(g_data['config'], g_data['time_ms'],
                   marker='s', linestyle='--',
                   label=f"MPI {graph.replace('data/', '').replace('.txt', '')}")

    ax.set_xlabel('Number of Threads / Processes')
    ax.set_ylabel('Execution Time (ms)')
    ax.set_title('PageRank Execution Time Scaling')
    ax.legend(bbox_to_anchor=(1.05, 1), loc='upper left')
    ax.grid(True, alpha=0.3)
    ax.set_xscale('log', base=2)
    ax.set_yscale('log')

    plt.tight_layout()
    out_path = os.path.join(PLOT_DIR, "scaling.png")
    plt.savefig(out_path, dpi=150, bbox_inches='tight')
    plt.close()
    print(f"Saved: {out_path}")


def generate_summary(df):
    """生成文本摘要"""
    summary_path = os.path.join(RESULTS_DIR, "analysis_summary.txt")
    with open(summary_path, 'w') as f:
        f.write("=" * 60 + "\n")
        f.write("  PageRank 并行算法实验结果分析\n")
        f.write("=" * 60 + "\n\n")

        # 串行基准
        serial = df[df['experiment'] == 'serial']
        if not serial.empty:
            f.write("1. Serial Baseline:\n")
            f.write("-" * 40 + "\n")
            for _, row in serial.iterrows():
                f.write(f"  {row['graph']}: {row['time_ms']:.2f} ms, "
                       f"{row['iterations']} iterations\n")
            f.write("\n")

        # OpenMP 最佳加速比
        omp = df[df['experiment'] == 'openmp']
        if not omp.empty:
            f.write("2. OpenMP Best Speedup:\n")
            f.write("-" * 40 + "\n")
            for graph in omp['graph'].unique():
                g_data = omp[omp['graph'] == graph]
                best = g_data.loc[g_data['speedup'].idxmax()]
                f.write(f"  {graph}: {best['speedup']:.2f}x "
                       f"(threads={int(best['config'])})\n")
            f.write("\n")

        # MPI 最佳加速比
        mpi = df[df['experiment'] == 'mpi']
        if not mpi.empty:
            f.write("3. MPI Best Speedup:\n")
            f.write("-" * 40 + "\n")
            for graph in mpi['graph'].unique():
                g_data = mpi[mpi['graph'] == graph]
                best = g_data.loc[g_data['speedup'].idxmax()]
                f.write(f"  {graph}: {best['speedup']:.2f}x "
                       f"(procs={int(best['config'])})\n")
            f.write("\n")

        f.write("=" * 60 + "\n")
        f.write("Plots saved in: results/plots/\n")

    print(f"Saved: {summary_path}")


def main():
    ensure_dirs()
    df = load_data()

    print("Generating plots...")
    plot_speedup(df)
    plot_efficiency(df)
    plot_runtime_comparison(df)
    plot_scaling(df)

    print("\nGenerating summary...")
    generate_summary(df)

    print("\nDone! All plots and summary are in the results/ directory.")


if __name__ == "__main__":
    main()
