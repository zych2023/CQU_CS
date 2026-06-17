"""
实验四：基于大语言模型的唐诗自动生成微调实验
使用 Qwen2-0.5B-Instruct + LoRA 进行唐诗续写微调
适配 CPU 环境 (无GPU)
"""

import os
import sys
import json
import warnings
warnings.filterwarnings("ignore")

# 修复Windows控制台编码问题
sys.stdout.reconfigure(encoding='utf-8')
sys.stderr.reconfigure(encoding='utf-8')

# ============================================================
# 0. 环境配置 — 设置镜像源 (放在所有import之前)
# ============================================================
os.environ["HF_ENDPOINT"] = "https://hf-mirror.com"
os.environ["TRANSFORMERS_OFFLINE"] = "0"  # 允许离线加载

# ============================================================
# 1. 导入库
# ============================================================
import torch
import numpy as np
from datasets import Dataset
from transformers import (
    AutoTokenizer,
    AutoModelForCausalLM,
    TrainingArguments,
    Trainer,
    DataCollatorForLanguageModeling,
)
from peft import LoraConfig, get_peft_model, PeftModel, TaskType
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

print("=" * 60)
print("实验四：基于大语言模型的唐诗自动生成微调实验")
print("=" * 60)
print(f"PyTorch 版本: {torch.__version__}")
print(f"CUDA 可用: {torch.cuda.is_available()}")
print(f"设备: CPU (本机无NVIDIA GPU)")

# ============================================================
# 2. 配置参数
# ============================================================
MODEL_NAME = "./models/Qwen/Qwen2-0___5B-Instruct"  # 本地模型路径
DATA_FILE = "poetry_utf8.txt"
TEST_FILE = "测试集.txt"
OUTPUT_DIR = "./tang_poetry_lora_adapter"
MAX_LENGTH = 128       # 序列最大长度
BATCH_SIZE = 2         # CPU环境下用小batch
GRADIENT_ACCUMULATION = 8  # 等效 batch_size = 16
LEARNING_RATE = 5e-5
NUM_EPOCHS = 5
LOGGING_STEPS = 10
SAVE_STEPS = 50

# ============================================================
# 3. 加载数据集
# ============================================================
print("\n[Step 1] 加载唐诗数据集...")

with open(DATA_FILE, "r", encoding="utf-8-sig") as f:
    poems = [line.strip() for line in f if line.strip()]

print(f"  共加载 {len(poems)} 首唐诗")
print(f"  示例: {poems[0]}")

with open(TEST_FILE, "r", encoding="utf-8") as f:
    test_poems = [line.strip() for line in f if line.strip()]

print(f"  测试集: {len(test_poems)} 条")

# ============================================================
# 4. 数据预处理 — 构造"续写诗歌"的训练样本
# ============================================================
print("\n[Step 2] 数据预处理 — 构造因果语言建模训练样本...")

def build_training_texts(poems):
    """
    将每首诗拆分为「前半句→后半句」的续写格式，用于因果语言建模。
    同时保留完整诗句作为整体训练样本。
    """
    texts = []
    for poem in poems:
        # 格式1: 完整诗句作为训练样本 (模型学习整首诗的分布)
        texts.append(poem)

        # 格式2: 续写格式 — 给出前半句，训练续写后半句
        # 按逗号或句号拆分（唐诗常见的标点）
        for sep in ["，", "。"]:
            parts = poem.split(sep)
            if len(parts) >= 3:
                # 取前半部分作为prompt，后半部分作为completion
                mid = len(parts) // 2
                prompt = sep.join(parts[:mid]) + sep
                completion = sep.join(parts[mid:])
                if completion.strip():
                    texts.append(prompt + completion)

    return texts

training_texts = build_training_texts(poems)
print(f"  生成 {len(training_texts)} 条训练样本")

# ============================================================
# 5. 加载分词器和模型
# ============================================================
print("\n[Step 3] 加载 Qwen2-0.5B-Instruct 模型和分词器...")

tokenizer = AutoTokenizer.from_pretrained(
    MODEL_NAME,
    trust_remote_code=True,
    padding_side="right",
)
if tokenizer.pad_token is None:
    tokenizer.pad_token = tokenizer.eos_token

model = AutoModelForCausalLM.from_pretrained(
    MODEL_NAME,
    torch_dtype=torch.float32,   # CPU用float32
    device_map="cpu",            # 强制CPU
    trust_remote_code=True,
    low_cpu_mem_usage=True,      # 低内存模式加载
)
model.config.use_cache = False  # 训练时关闭KV cache

print(f"  模型参数量: {model.num_parameters():,}")
print(f"  词表大小: {len(tokenizer)}")

# ============================================================
# 6. 基线测试 — 微调前生成效果
# ============================================================
print("\n[Step 4] 基线测试 — 微调前模型生成效果...")

def generate_poem(model, tokenizer, prompt, max_new_tokens=80):
    """给定前半句，生成续写"""
    inputs = tokenizer(prompt, return_tensors="pt")
    with torch.no_grad():
        outputs = model.generate(
            **inputs,
            max_new_tokens=max_new_tokens,
            do_sample=True,
            temperature=0.8,
            top_p=0.9,
            repetition_penalty=1.2,
            eos_token_id=tokenizer.eos_token_id,
        )
    generated = tokenizer.decode(outputs[0], skip_special_tokens=True)
    return generated

# 选取几条测试句进行基线测试
baseline_results = []
print("\n  ---- 基线模型 (微调前) 生成结果 ----")
for i, test_poem in enumerate(test_poems[:5]):
    # 取每首诗的第一句作为prompt
    parts = test_poem.replace("。", "，").split("，")
    prompt = parts[0] + "，" if len(parts) > 1 else test_poem[:len(test_poem)//2]
    result = generate_poem(model, tokenizer, prompt)
    baseline_results.append({"prompt": prompt, "generated": result, "reference": test_poem})
    print(f"\n  [{i+1}] Prompt: {prompt}")
    print(f"      生成: {result}")
    print(f"      参考: {test_poem}")

# ============================================================
# 7. 数据Tokenization
# ============================================================
print("\n[Step 5] Tokenization...")

def tokenize_function(examples):
    """对训练文本进行tokenize"""
    result = tokenizer(
        examples["text"],
        truncation=True,
        max_length=MAX_LENGTH,
        padding="max_length",
    )
    result["labels"] = result["input_ids"].copy()
    return result

dataset = Dataset.from_dict({"text": training_texts})
tokenized_dataset = dataset.map(tokenize_function, batched=True, remove_columns=["text"])

# 划分训练集和验证集 (90/10)
split = tokenized_dataset.train_test_split(test_size=0.1, seed=42)
train_dataset = split["train"]
eval_dataset = split["test"]

print(f"  训练集: {len(train_dataset)} 条")
print(f"  验证集: {len(eval_dataset)} 条")

# ============================================================
# 8. 配置 LoRA
# ============================================================
print("\n[Step 6] 配置 LoRA 微调...")

lora_config = LoraConfig(
    task_type=TaskType.CAUSAL_LM,
    r=8,                        # LoRA秩
    lora_alpha=32,              # 缩放因子
    lora_dropout=0.1,           # Dropout
    target_modules=["q_proj", "v_proj", "k_proj", "o_proj",
                    "gate_proj", "up_proj", "down_proj"],  # 目标线性层
    bias="none",
)

model = get_peft_model(model, lora_config)
model.print_trainable_parameters()

# 开启梯度检查点以节省内存
model.enable_input_require_grads()  # 必须：梯度检查点+LoRA需要
model.gradient_checkpointing_enable()
print("  梯度检查点已开启 (节省内存)")

# ============================================================
# 9. 训练配置
# ============================================================
print("\n[Step 7] 配置训练参数...")

training_args = TrainingArguments(
    output_dir=OUTPUT_DIR,
    num_train_epochs=NUM_EPOCHS,
    per_device_train_batch_size=BATCH_SIZE,
    per_device_eval_batch_size=BATCH_SIZE,
    gradient_accumulation_steps=GRADIENT_ACCUMULATION,
    learning_rate=LEARNING_RATE,
    weight_decay=0.01,
    warmup_steps=50,
    fp16=False,                 # CPU不支持fp16
    bf16=False,                 # CPU不支持bf16
    logging_steps=LOGGING_STEPS,
    save_steps=SAVE_STEPS,
    save_total_limit=2,
    evaluation_strategy="steps",
    eval_steps=SAVE_STEPS,
    load_best_model_at_end=False,
    report_to="none",           # 不上报到wandb等
    dataloader_pin_memory=False, # CPU环境关闭
    remove_unused_columns=False,
)

# Data collator
data_collator = DataCollatorForLanguageModeling(
    tokenizer=tokenizer,
    mlm=False,  # 因果语言建模，不是MLM
)

# ============================================================
# 10. 训练
# ============================================================
print("\n[Step 8] 开始训练...")
print(f"  学习率: {LEARNING_RATE}")
print(f"  批次大小: {BATCH_SIZE} x {GRADIENT_ACCUMULATION} = {BATCH_SIZE * GRADIENT_ACCUMULATION}")
print(f"  训练轮数: {NUM_EPOCHS}")
print(f"  设备: CPU")

trainer = Trainer(
    model=model,
    args=training_args,
    train_dataset=train_dataset,
    eval_dataset=eval_dataset,
    data_collator=data_collator,
    tokenizer=tokenizer,
)

train_result = trainer.train()

# ============================================================
# 11. 保存模型
# ============================================================
print("\n[Step 9] 保存微调后的 LoRA 适配器...")

trainer.save_model(OUTPUT_DIR)
tokenizer.save_pretrained(OUTPUT_DIR)
print(f"  模型已保存至: {OUTPUT_DIR}")

# ============================================================
# 12. 绘制训练损失曲线
# ============================================================
print("\n[Step 10] 绘制训练损失曲线...")

log_history = trainer.state.log_history
train_losses = [(x["step"], x["loss"]) for x in log_history if "loss" in x]
eval_losses = [(x["step"], x["eval_loss"]) for x in log_history if "eval_loss" in x]

fig, ax = plt.subplots(figsize=(10, 6))
if train_losses:
    steps, losses = zip(*train_losses)
    ax.plot(steps, losses, label="Training Loss", color="blue", linewidth=1.5)
if eval_losses:
    steps, losses = zip(*eval_losses)
    ax.plot(steps, losses, label="Validation Loss", color="red", linewidth=1.5, linestyle="--")
ax.set_xlabel("Steps", fontsize=12)
ax.set_ylabel("Loss", fontsize=12)
ax.set_title("LoRA Fine-tuning Loss Curve - Qwen2-0.5B Tang Poetry", fontsize=14)
ax.legend(fontsize=11)
ax.grid(True, alpha=0.3)
plt.tight_layout()
plt.savefig("loss_curve.png", dpi=150)
print("  损失曲线已保存至: loss_curve.png")

# ============================================================
# 13. 加载微调后模型 & 推理对比
# ============================================================
print("\n[Step 11] 加载模型进行推理对比...")

# 加载基线模型 (用于baseline对比)
print("  加载基线模型...")
base_model = AutoModelForCausalLM.from_pretrained(
    MODEL_NAME,
    torch_dtype=torch.float32,
    device_map="cpu",
    trust_remote_code=True,
)
base_model.eval()

# 加载微调后的 LoRA 模型 (单独加载，避免修改base_model)
print("  加载微调后的 LoRA 模型...")
finetuned_base = AutoModelForCausalLM.from_pretrained(
    MODEL_NAME,
    torch_dtype=torch.float32,
    device_map="cpu",
    trust_remote_code=True,
)
finetuned_model = PeftModel.from_pretrained(finetuned_base, OUTPUT_DIR)
finetuned_model.eval()

# ============================================================
# 14. 对比测试 — 至少10个案例
# ============================================================
print("\n" + "=" * 70)
print("  对比测试：Baseline vs LoRA 微调模型")
print("=" * 70)

comparison_results = []

for i, test_poem in enumerate(test_poems):
    parts = test_poem.replace("。", "，").split("，")
    prompt = parts[0] + "，" if len(parts) > 1 else test_poem[:len(test_poem)//2]

    # 基线模型生成 (用重新加载的干净基线模型)
    baseline_output = generate_poem(base_model, tokenizer, prompt)

    # 微调模型生成 (加载了LoRA适配器的模型)
    finetuned_output = generate_poem(finetuned_model, tokenizer, prompt)

    comparison_results.append({
        "id": i + 1,
        "prompt": prompt,
        "reference": test_poem,
        "baseline": baseline_output,
        "finetuned": finetuned_output,
    })

    print(f"\n  ---- 案例 {i+1} ----")
    print(f"  Prompt:    {prompt}")
    print(f"  参考原文:  {test_poem}")
    print(f"  Baseline:  {baseline_output}")
    print(f"  LoRA微调:  {finetuned_output}")

# 保存对比结果
with open("comparison_results.json", "w", encoding="utf-8") as f:
    json.dump(comparison_results, f, ensure_ascii=False, indent=2)

print("\n\n" + "=" * 70)
print("  实验完成！")
print("=" * 70)
print(f"  输出文件:")
print(f"    - {OUTPUT_DIR}/        (LoRA适配器权重)")
print(f"    - loss_curve.png       (训练损失曲线)")
print(f"    - comparison_results.json (对比结果)")
print("=" * 70)
