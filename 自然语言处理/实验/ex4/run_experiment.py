"""
实验四：基于大语言模型的唐诗自动生成微调实验
镜像: 1.12.1-cuda10.2-py3.9.11-ubuntu22.04-x86_64
运行: python run_experiment.py
"""

import subprocess
import sys
import os

# ============================================================
# 第一步：安装依赖
# ============================================================
def run(cmd):
    """执行命令，失败则报错"""
    subprocess.check_call(cmd)

def install_deps():
    # 1. 锁定 numpy 版本（防止和 modelarts pandas 冲突）
    print("步骤1/7: 锁定 numpy<2.0 ...")
    run([sys.executable, "-m", "pip", "install", "numpy<2.0", "-q"])

    # 2. 升级 PyTorch 到 1.13.1+cu113
    #    驱动 11.4 向下兼容 CUDA 11.3
    #    先试阿里云镜像，失败则用官方源
    print("步骤2/7: 升级 PyTorch 到 1.13.1+cu113 ...")
    pytorch_cmd = [
        sys.executable, "-m", "pip", "install",
        "torch==1.13.1+cu113",
        "torchvision==0.14.1+cu113",
        "torchaudio==0.13.1",
    ]
    try:
        run(pytorch_cmd + ["-f", "https://mirrors.aliyun.com/pytorch-wheels/cu113/", "-q"])
        print("  -> 阿里云镜像下载成功")
    except Exception:
        print("  -> 阿里云镜像失败，尝试官方源（可能较慢）...")
        run(pytorch_cmd + ["-f", "https://download.pytorch.org/whl/cu113", "-q"])
        print("  -> 官方源下载成功")

    # 3. 安装 transformers（会自动装兼容的 tokenizers/huggingface_hub）
    print("步骤3/7: 安装 transformers==4.37.0 ...")
    run([sys.executable, "-m", "pip", "install", "transformers==4.37.0", "-q"])

    # 4. 安装 datasets（指定兼容版本，避免拉到 numpy 2.x）
    print("步骤4/7: 安装 datasets==2.16.1 ...")
    run([sys.executable, "-m", "pip", "install", "datasets==2.16.1", "-q"])

    # 5. 安装 peft
    print("步骤5/7: 安装 peft==0.6.2 ...")
    run([sys.executable, "-m", "pip", "install", "peft==0.6.2", "-q"])

    # 6. 安装 accelerate
    print("步骤6/7: 安装 accelerate==0.24.1 ...")
    run([sys.executable, "-m", "pip", "install", "accelerate==0.24.1", "-q"])

    # 7. 安装 matplotlib
    print("步骤7/7: 安装 matplotlib ...")
    run([sys.executable, "-m", "pip", "install", "matplotlib", "-q"])

print("=" * 50)
print("开始安装依赖（首次约10-15分钟）")
print("=" * 50)
install_deps()
print("\n依赖安装完成！\n")

# 设置 HuggingFace 镜像（加速模型下载）
os.environ["HF_ENDPOINT"] = "https://hf-mirror.com"

# ============================================================
# 第二步：导入库
# ============================================================
import torch
import json
from transformers import AutoModelForCausalLM, AutoTokenizer, TrainingArguments, Trainer
from datasets import Dataset
from peft import LoraConfig, get_peft_model, PeftModel, TaskType

device = "cuda" if torch.cuda.is_available() else "cpu"
print(f"当前设备: {device}")
print(f"PyTorch 版本: {torch.__version__}")
if device == "cuda":
    print(f"GPU: {torch.cuda.get_device_name(0)}")
    print(f"CUDA 版本: {torch.version.cuda}")
else:
    print("警告：未检测到 GPU，将使用 CPU 训练（会很慢）")

# ============================================================
# 第三步：加载模型
# ============================================================
MODEL_NAME = "Qwen/Qwen2-0.5B-Instruct"
print(f"\n正在加载模型: {MODEL_NAME} ...")

tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME, trust_remote_code=True)
model = AutoModelForCausalLM.from_pretrained(
    MODEL_NAME,
    device_map="auto" if device == "cuda" else None,
    torch_dtype=torch.float16 if device == "cuda" else torch.float32,
    trust_remote_code=True,
)
if device == "cpu":
    model = model.to("cpu")

print("模型加载完成！")
print(f"模型参数量: {sum(p.numel() for p in model.parameters()) / 1e6:.1f}M")

# ============================================================
# 第四步：生成函数
# ============================================================
def generate_poetry(prompt, mdl, max_len=80, temp=0.7, top_k=40):
    inputs = tokenizer(prompt, return_tensors="pt").to(mdl.device)
    with torch.no_grad():
        outputs = mdl.generate(
            inputs.input_ids,
            max_new_tokens=max_len,
            do_sample=True,
            temperature=temp,
            top_k=top_k,
            pad_token_id=tokenizer.eos_token_id,
            eos_token_id=tokenizer.eos_token_id,
        )
    return tokenizer.decode(outputs[0], skip_special_tokens=True)

# ============================================================
# 第五步：测试集
# ============================================================
test_prompts = [
    "床前明月光，", "白日依山尽，", "红豆生南国，",
    "空山不见人，", "独坐幽篁里，", "春眠不觉晓，",
    "千山鸟飞绝，", "松下问童子，", "功盖三分国，",
    "绿蚁新醅酒，", "寒雨连江夜入吴，",
    "黄河远上白云间，", "独在异乡为异客，",
]

# ============================================================
# 第六步：Baseline 推理
# ============================================================
print("\n" + "=" * 60)
print("Baseline 模型（未微调）生成结果")
print("=" * 60)

baseline_results = []
for prompt in test_prompts:
    result = generate_poetry(prompt, model)
    baseline_results.append({"prompt": prompt, "output": result})
    print(f"\n输入: {prompt}")
    print(f"输出: {result}")
    print("-" * 40)

# ============================================================
# 第七步：加载训练数据
# ============================================================
print("\n" + "=" * 60)
print("数据准备")
print("=" * 60)

poems = []
for enc in ["utf-8", "gbk", "gb2312", "gb18030"]:
    try:
        with open("唐诗三百 - small.txt", "r", encoding=enc) as f:
            poems = [line.strip() for line in f.readlines() if line.strip()]
        print(f"使用编码 {enc} 成功读取，共 {len(poems)} 首诗")
        break
    except:
        continue

if not poems:
    with open("poetry_utf8.txt", "r", encoding="utf-8") as f:
        poems = [line.strip() for line in f.readlines() if line.strip()]
    print(f"使用 poetry_utf8.txt，共 {len(poems)} 首诗")

if not poems:
    print("错误：无法读取训练数据！")
    sys.exit(1)

print("\n前5首诗:")
for i, p in enumerate(poems[:5]):
    print(f"  {i+1}. {p}")

# ============================================================
# 第八步：数据预处理
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
print(f"\n训练样本数: {len(train_dataset)}")

# ============================================================
# 第九步：配置 LoRA
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

print(f"\nLoRA 配置:")
print(f"  r = {lora_config.r}")
print(f"  lora_alpha = {lora_config.lora_alpha}")
print(f"  target_modules = {lora_config.target_modules}")
print(f"  lora_dropout = {lora_config.lora_dropout}")

# ============================================================
# 第十步：训练
# ============================================================
training_args = TrainingArguments(
    output_dir="./qwen-poetry-lora",
    learning_rate=5e-5,
    per_device_train_batch_size=4,
    num_train_epochs=5,
    fp16=(device == "cuda"),
    save_strategy="epoch",
    logging_steps=10,
    report_to="none",
    remove_unused_columns=False,
)

print(f"\n训练参数:")
print(f"  学习率: {training_args.learning_rate}")
print(f"  批次大小: {training_args.per_device_train_batch_size}")
print(f"  训练轮数: {training_args.num_train_epochs}")
print(f"  fp16: {training_args.fp16}")

trainer = Trainer(
    model=model_lora, args=training_args, train_dataset=train_dataset,
)

print("\n开始训练...")
train_result = trainer.train()
print(f"\n训练完成！")
print(f"总训练步数: {train_result.global_step}")
print(f"最终 Loss: {train_result.training_loss:.4f}")

# ============================================================
# 第十一步：Loss 曲线
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
# 第十二步：保存模型
# ============================================================
save_dir = "./qwen-poetry-lora-final"
model_lora.save_pretrained(save_dir)
tokenizer.save_pretrained(save_dir)
print(f"LoRA 权重已保存到: {save_dir}")

# ============================================================
# 第十三步：对比测试
# ============================================================
print("\n" + "=" * 60)
print("推理对比")
print("=" * 60)

print("重新加载基线模型...")
base_model = AutoModelForCausalLM.from_pretrained(
    MODEL_NAME,
    device_map="auto" if device == "cuda" else None,
    torch_dtype=torch.float16 if device == "cuda" else torch.float32,
    trust_remote_code=True,
)
if device == "cpu":
    base_model = base_model.to("cpu")

print("加载 LoRA 权重...")
finetuned_model = PeftModel.from_pretrained(base_model, save_dir)
print("微调模型加载完成！")

print("\n" + "=" * 70)
print("Baseline vs LoRA 微调 对比结果")
print("=" * 70)

comparison_results = []
for prompt in test_prompts:
    baseline_out = generate_poetry(prompt, model, max_len=60)
    lora_out = generate_poetry(prompt, finetuned_model, max_len=60)
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
# 第十四步：总结
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
