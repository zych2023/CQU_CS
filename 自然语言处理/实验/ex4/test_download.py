import os
from transformers import AutoTokenizer
print("Downloading tokenizer...")
t = AutoTokenizer.from_pretrained("Qwen/Qwen2-0.5B-Instruct", trust_remote_code=True)
print(f"Tokenizer OK, vocab size: {t.vocab_size}")
