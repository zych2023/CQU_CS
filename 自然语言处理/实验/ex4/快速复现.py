"""
快速复现脚本 - 加载已训练的模型，生成对比结果
运行方式: python 快速复现.py
"""

import sys
import io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')

import torch
import json
from transformers import AutoModelForCausalLM, AutoTokenizer
from peft import PeftModel

MODEL_NAME = "Qwen/Qwen2-0.5B-Instruct"
LORA_DIR = "./qwen-poetry-lora-final"

print("=" * 60)
print("快速复现：Baseline vs LoRA 微调对比")
print("=" * 60)

# 1. 加载 tokenizer
print("\n[1/4] 加载 tokenizer...")
tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME, trust_remote_code=True)

# 2. 加载基线模型
print("[2/4] 加载基线模型...")
base_model = AutoModelForCausalLM.from_pretrained(
    MODEL_NAME, torch_dtype=torch.float32, trust_remote_code=True,
).to("cpu")

# 3. 加载 LoRA 模型
print("[3/4] 加载 LoRA 微调模型...")
lora_model = PeftModel.from_pretrained(base_model, LORA_DIR)

# 4. 生成函数
def generate(prompt, model, max_len=60):
    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)
    with torch.no_grad():
        outputs = model.generate(
            **inputs,
            max_new_tokens=max_len,
            do_sample=True,
            temperature=0.7,
            top_k=40,
            pad_token_id=tokenizer.eos_token_id,
            eos_token_id=tokenizer.eos_token_id,
        )
    return tokenizer.decode(outputs[0], skip_special_tokens=True)

# 5. 测试 Prompt
test_prompts = [
    "床前明月光，",
    "白日依山尽，",
    "红豆生南国，",
    "空山不见人，",
    "独坐幽篁里，",
    "春眠不觉晓，",
    "千山鸟飞绝，",
    "松下问童子，",
    "功盖三分国，",
    "绿蚁新醅酒，",
    "寒雨连江夜入吴，",
    "黄河远上白云间，",
    "独在异乡为异客，",
]

# 6. 对比测试
print("[4/4] 生成对比结果...\n")
print("=" * 70)
print("Baseline vs LoRA 微调 对比结果")
print("=" * 70)

results = []
for i, prompt in enumerate(test_prompts, 1):
    baseline_out = generate(prompt, base_model)
    lora_out = generate(prompt, lora_model)
    results.append({
        "prompt": prompt,
        "baseline": baseline_out,
        "lora": lora_out
    })
    print(f"\n[{i}] 输入: {prompt}")
    print(f"    Baseline: {baseline_out[:80]}...")
    print(f"    LoRA微调: {lora_out[:80]}...")
    print("-" * 50)

# 7. 保存结果
with open("复现结果.json", "w", encoding="utf-8") as f:
    json.dump(results, f, ensure_ascii=False, indent=2)

print("\n对比结果已保存到: 复现结果.json")
print("实验完成！")
