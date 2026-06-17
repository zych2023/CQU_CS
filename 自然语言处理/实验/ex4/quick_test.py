import torch
from transformers import AutoModelForCausalLM, AutoTokenizer, TrainingArguments, Trainer
from datasets import Dataset
from peft import LoraConfig, get_peft_model, PeftModel, TaskType
print(f"PyTorch: {torch.__version__}")
print("All imports OK")

with open("poetry_utf8.txt", "r", encoding="utf-8-sig") as f:
    poems = [line.strip() for line in f.readlines() if line.strip()]
print(f"Poems: {len(poems)}")
print(f"First: {poems[0]}")
print("Data OK")
