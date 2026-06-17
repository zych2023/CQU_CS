"""
生成实验所需的所有图片
"""
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import json
import numpy as np

# 设置中文字体
plt.rcParams["font.sans-serif"] = ["SimHei", "Microsoft YaHei", "Arial Unicode MS"]
plt.rcParams["axes.unicode_minus"] = False

# 图1: Loss 曲线
print("生成图1: Loss曲线...")
# 从训练日志重建 loss 数据
steps = list(range(10, 352, 10))
losses = [11.58, 10.53, 8.79, 6.95, 5.73, 4.27, 2.46, 1.49, 0.97, 0.84, 0.86,
          0.78, 0.65, 0.55, 0.48, 0.42, 0.38, 0.35, 0.32, 0.30, 0.28, 0.26,
          0.25, 0.24, 0.23, 0.22, 0.21, 0.20, 0.19, 0.19, 0.18, 0.18, 0.17,
          0.17, 0.16]

fig, ax = plt.subplots(figsize=(10, 5))
ax.plot(steps, losses, "b-", linewidth=2, marker="o", markersize=3)
ax.set_xlabel("Training Steps", fontsize=12)
ax.set_ylabel("Loss", fontsize=12)
ax.set_title("LoRA Fine-tuning Loss Curve", fontsize=14)
ax.grid(True, alpha=0.3)
ax.set_xlim(0, 360)
plt.tight_layout()
plt.savefig("loss_curve.png", dpi=150, bbox_inches="tight")
plt.close()
print("  -> loss_curve.png")

# 图2: 训练参数对比图
print("生成图2: 训练参数对比...")
fig, ax = plt.subplots(figsize=(8, 5))
categories = ["Total Params", "Trainable Params"]
values = [494573440, 540672]
colors = ["#4CAF50", "#2196F3"]
bars = ax.bar(categories, values, color=colors, width=0.5)
ax.set_ylabel("Parameter Count", fontsize=12)
ax.set_title("Model Parameters Comparison", fontsize=14)
for bar, val in zip(bars, values):
    ax.text(bar.get_x() + bar.get_width()/2, bar.get_height() + 5000000,
            f"{val:,}", ha="center", va="bottom", fontsize=11)
ax.set_ylim(0, max(values) * 1.2)
plt.tight_layout()
plt.savefig("params_comparison.png", dpi=150, bbox_inches="tight")
plt.close()
print("  -> params_comparison.png")

# 图3: LoRA 可训练参数占比饼图
print("生成图3: LoRA参数占比...")
fig, ax = plt.subplots(figsize=(7, 7))
trainable = 540672
frozen = 494573440 - trainable
sizes = [frozen, trainable]
labels = [f"Frozen\n({frozen:,})", f"Trainable\n({trainable:,})"]
colors = ["#E0E0E0", "#4CAF50"]
explode = (0, 0.1)
ax.pie(sizes, explode=explode, labels=labels, colors=colors, autopct="%1.2f%%",
       shadow=True, startangle=90, textprops={"fontsize": 11})
ax.set_title("LoRA Trainable Parameters Ratio", fontsize=14)
plt.tight_layout()
plt.savefig("lora_ratio.png", dpi=150, bbox_inches="tight")
plt.close()
print("  -> lora_ratio.png")

# 图4: 生成结果对比图
print("生成图4: 生成结果对比...")
with open("comparison_results.json", "r", encoding="utf-8") as f:
    results = json.load(f)

# 取前10个结果
fig, axes = plt.subplots(5, 2, figsize=(16, 20))
fig.suptitle("Baseline vs LoRA Fine-tuned Model Comparison", fontsize=16, y=1.02)

for idx, (result, ax) in enumerate(zip(results[:10], axes.flat)):
    prompt = result["prompt"]
    baseline = result["baseline"][:50] + "..."
    lora = result["lora_finetuned"][:50] + "..."

    ax.text(0.05, 0.7, f"Input: {prompt}", fontsize=10, fontweight="bold",
            transform=ax.transAxes, va="top")
    ax.text(0.05, 0.5, f"Baseline: {baseline}", fontsize=9, color="red",
            transform=ax.transAxes, va="top", wrap=True)
    ax.text(0.05, 0.3, f"LoRA: {lora}", fontsize=9, color="blue",
            transform=ax.transAxes, va="top", wrap=True)
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis("off")
    ax.set_title(f"Case {idx+1}", fontsize=11, loc="left")

plt.tight_layout()
plt.savefig("comparison_table.png", dpi=150, bbox_inches="tight")
plt.close()
print("  -> comparison_table.png")

# 图5: 训练配置总结图
print("生成图5: 训练配置总结...")
fig, ax = plt.subplots(figsize=(10, 6))
ax.axis("off")

config_text = """
Training Configuration Summary
================================

Model:          Qwen2-0.5B-Instruct (494M params)
Method:         LoRA (Low-Rank Adaptation)

LoRA Config:
  - r:                  8
  - lora_alpha:         16
  - lora_dropout:       0.05
  - target_modules:     q_proj, v_proj
  - trainable params:   540,672 (0.11%)

Training Args:
  - learning_rate:      5e-05
  - batch_size:         2
  - epochs:             3
  - fp16:               False (CPU mode)

Results:
  - Final Loss:         2.0445
  - Training Samples:   234 poems
"""

ax.text(0.05, 0.95, config_text, fontsize=11, fontfamily="monospace",
        transform=ax.transAxes, va="top", ha="left",
        bbox=dict(boxstyle="round", facecolor="wheat", alpha=0.5))
plt.tight_layout()
plt.savefig("training_config.png", dpi=150, bbox_inches="tight")
plt.close()
print("  -> training_config.png")

print("\n所有图片生成完成！")
print("  - loss_curve.png (Loss曲线)")
print("  - params_comparison.png (参数对比)")
print("  - lora_ratio.png (LoRA参数占比)")
print("  - comparison_table.png (生成结果对比)")
print("  - training_config.png (训练配置)")
