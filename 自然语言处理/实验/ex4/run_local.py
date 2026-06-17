"""
实验四：基于大语言模型的唐诗自动生成微调实验
本地运行版本（CPU）
"""

import os
import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')
import torch
import json
from transformers import AutoModelForCausalLM, AutoTokenizer, TrainingArguments, Trainer
from datasets import Dataset
from peft import LoraConfig, get_peft_model, PeftModel, TaskType

# 设置
device = "cpu"
MODEL_NAME = "Qwen/Qwen2-0.5B-Instruct"

print(f"设备: {device}")
print(f"PyTorch: {torch.__version__}")

# ============================================================
# 加载模型
# ============================================================
print(f"\n正在加载模型: {MODEL_NAME} ...")
print("(首次运行需要下载约1GB，请耐心等待)")

tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME, trust_remote_code=True)
model = AutoModelForCausalLM.from_pretrained(
    MODEL_NAME,
    torch_dtype=torch.float32,
    trust_remote_code=True,
).to(device)

print("模型加载完成！")
print(f"参数量: {sum(p.numel() for p in model.parameters()) / 1e6:.1f}M")

# ============================================================
# 生成函数
# ============================================================
def generate_poetry(prompt, mdl, max_len=80, temp=0.7, top_k=40):
    inputs = tokenizer(prompt, return_tensors="pt").to(mdl.device)
    with torch.no_grad():
        outputs = mdl.generate(
            **inputs,
            max_new_tokens=max_len,
            do_sample=True,
            temperature=temp,
            top_k=top_k,
            pad_token_id=tokenizer.eos_token_id,
            eos_token_id=tokenizer.eos_token_id,
        )
    return tokenizer.decode(outputs[0], skip_special_tokens=True)

# ============================================================
# 测试集
# ============================================================
test_prompts = [
    "床前明月光，", "白日依山尽，", "红豆生南国，",
    "空山不见人，", "独坐幽篁里，", "春眠不觉晓，",
    "千山鸟飞绝，", "松下问童子，", "功盖三分国，",
    "绿蚁新醅酒，", "寒雨连江夜入吴，",
    "黄河远上白云间，", "独在异乡为异客，",
]

# ============================================================
# Baseline 推理
# ============================================================
print("\n" + "=" * 60)
print("Baseline 模型（未微调）生成结果")
print("=" * 60)

baseline_results = []
for prompt in test_prompts:
    result = generate_poetry(prompt, model, max_len=40)
    baseline_results.append({"prompt": prompt, "output": result})
    print(f"\n输入: {prompt}")
    print(f"输出: {result}")
    print("-" * 40)

# ============================================================
# 加载训练数据
# ============================================================
print("\n" + "=" * 60)
print("数据准备")
print("=" * 60)

poems = []
with open("poetry_utf8.txt", "r", encoding="utf-8-sig") as f:
    poems = [line.strip() for line in f.readlines() if line.strip()]
print(f"读取 {len(poems)} 首诗")
print(f"第1首: {poems[0]}")

# ============================================================
# 数据预处理
# ============================================================
def preprocess_poems(poem_list, tok, max_length=128):
    encodings = tok(
        poem_list, truncation=True, max_length=max_length,
        padding="max_length", return_tensors="pt",
    )
    return Dataset.from_dict({
        "input_ids": encodings["input_ids"],
        "attention_mask": encodings["attention_mask"],
        "labels": encodings["input_ids"].clone(),
    })

train_dataset = preprocess_poems(poems, tokenizer)
print(f"训练样本数: {len(train_dataset)}")

# ============================================================
# 配置 LoRA
# ============================================================
print("\n" + "=" * 60)
print("LoRA 微调")
print("=" * 60)

lora_config = LoraConfig(
    task_type=TaskType.CAUSAL_LM,
    r=8, lora_alpha=16, lora_dropout=0.05,
    target_modules=["q_proj", "v_proj"],
)

model_lora = get_peft_model(model, lora_config)
model_lora.print_trainable_parameters()

# ============================================================
# 训练（CPU 版本，减少轮数）
# ============================================================
training_args = TrainingArguments(
    output_dir="./qwen-poetry-lora-output",
    learning_rate=5e-5,
    per_device_train_batch_size=2,
    num_train_epochs=3,
    fp16=False,
    save_strategy="no",
    logging_steps=10,
    report_to="none",
    remove_unused_columns=False,
)

print(f"\n训练参数:")
print(f"  学习率: {training_args.learning_rate}")
print(f"  批次大小: {training_args.per_device_train_batch_size}")
print(f"  训练轮数: {training_args.num_train_epochs}")
print(f"  设备: CPU (较慢，请耐心等待)")

trainer = Trainer(
    model=model_lora, args=training_args, train_dataset=train_dataset,
)

print("\n开始训练...")
train_result = trainer.train()
print(f"\n训练完成！")
print(f"最终 Loss: {train_result.training_loss:.4f}")

# ============================================================
# Loss 曲线
# ============================================================
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

logs = trainer.state.log_history
train_loss = [x["loss"] for x in logs if "loss" in x]
steps = [x["step"] for x in logs if "loss" in x]

plt.figure(figsize=(10, 5))
plt.plot(steps, train_loss, "b-", linewidth=2)
plt.xlabel("Training Steps")
plt.ylabel("Loss")
plt.title("LoRA Fine-tuning Loss Curve")
plt.grid(True)
plt.savefig("loss_curve.png", dpi=150, bbox_inches="tight")
print("Loss 曲线已保存为 loss_curve.png")

# ============================================================
# 保存模型
# ============================================================
save_dir = "./qwen-poetry-lora-final"
model_lora.save_pretrained(save_dir)
tokenizer.save_pretrained(save_dir)
print(f"LoRA 权重已保存到: {save_dir}")

# ============================================================
# 对比测试
# ============================================================
print("\n" + "=" * 60)
print("推理对比")
print("=" * 60)

print("重新加载基线模型...")
base_model = AutoModelForCausalLM.from_pretrained(
    MODEL_NAME, torch_dtype=torch.float32, trust_remote_code=True,
).to(device)

print("加载 LoRA 权重...")
finetuned_model = PeftModel.from_pretrained(base_model, save_dir)
print("微调模型加载完成！")

print("\n" + "=" * 70)
print("Baseline vs LoRA 微调 对比结果")
print("=" * 70)

comparison_results = []
for prompt in test_prompts:
    baseline_out = generate_poetry(prompt, model, max_len=40)
    lora_out = generate_poetry(prompt, finetuned_model, max_len=40)
    comparison_results.append({
        "prompt": prompt, "baseline": baseline_out, "lora_finetuned": lora_out,
    })
    print(f"\n输入: {prompt}")
    print(f"  Baseline:  {baseline_out}")
    print(f"  LoRA微调:  {lora_out}")
    print("-" * 50)

with open("comparison_results.json", "w", encoding="utf-8") as f:
    json.dump(comparison_results, f, ensure_ascii=False, indent=2)
print("\n对比结果已保存到 comparison_results.json")

# ============================================================
# 总结
# ============================================================
print("\n" + "=" * 70)
print("实验总结")
print("=" * 70)
print(f"训练样本数: {len(poems)}")
print(f"训练轮数: {training_args.num_train_epochs}")
print(f"学习率: {training_args.learning_rate}")
print(f"LoRA rank: {lora_config.r}")
print(f"最终 Loss: {train_result.training_loss:.4f}")
print(f"\n测试 Prompt 数: {len(test_prompts)}")
print("\n输出文件:")
print("  - loss_curve.png (Loss 曲线)")
print("  - comparison_results.json (对比结果)")
print("  - qwen-poetry-lora-final/ (微调模型)")
print("\n实验完成！")
