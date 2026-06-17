"""
Local test script
"""
import sys
print(f"Python: {sys.version}")

# Test 1: imports
print("\nTest 1: imports...")
try:
    import torch
    from transformers import AutoModelForCausalLM, AutoTokenizer, TrainingArguments, Trainer
    from datasets import Dataset
    from peft import LoraConfig, get_peft_model, PeftModel, TaskType
    print("  [OK] all imports ok")
    print(f"  PyTorch: {torch.__version__}")
except Exception as e:
    print(f"  [FAIL] import error: {e}")
    sys.exit(1)

# Test 2: read data
print("\nTest 2: read training data...")
poems = []
for enc in ["utf-8", "gbk", "gb2312", "gb18030"]:
    try:
        with open("poetry_utf8.txt", "r", encoding="utf-8-sig") as f:
            poems = [line.strip() for line in f.readlines() if line.strip()]
        print(f"  [OK] encoding utf-8-sig, got {len(poems)} poems")
        break
    except:
        continue

print(f"  First poem: {poems[0]}")

# Test 3: test prompts
print("\nTest 3: test prompts...")
test_prompts = [
    "chuang qian ming yue guang,",
    "bai ri yi shan jin,",
]
print(f"  [OK] {len(test_prompts)} prompts")

# Test 4: LoRA + Trainer flow
print("\nTest 4: LoRA + Trainer flow...")
try:
    from transformers import GPT2Config, GPT2LMHeadModel

    tiny_tokenizer = AutoTokenizer.from_pretrained("gpt2")
    tiny_tokenizer.pad_token = tiny_tokenizer.eos_token
    config = GPT2Config(
        vocab_size=len(tiny_tokenizer),
        n_positions=128,
        n_embd=64,
        n_layer=2,
        n_head=2,
    )
    tiny_model = GPT2LMHeadModel(config)

    lora_config = LoraConfig(
        task_type=TaskType.CAUSAL_LM,
        r=8, lora_alpha=16, lora_dropout=0.05,
        target_modules=["c_attn"],
    )
    model_lora = get_peft_model(tiny_model, lora_config)
    model_lora.print_trainable_parameters()

    encodings = tiny_tokenizer(
        ["Hello world this is a test.", "Another test sentence here."],
        truncation=True, max_length=32, padding="max_length", return_tensors="pt"
    )
    train_dataset = Dataset.from_dict({
        "input_ids": encodings["input_ids"],
        "attention_mask": encodings["attention_mask"],
        "labels": encodings["input_ids"].clone(),
    })

    training_args = TrainingArguments(
        output_dir="./test_output",
        num_train_epochs=1,
        per_device_train_batch_size=1,
        logging_steps=1,
        report_to="none",
        remove_unused_columns=False,
    )
    trainer = Trainer(
        model=model_lora, args=training_args, train_dataset=train_dataset,
    )
    result = trainer.train()
    print(f"  [OK] training done, loss: {result.training_loss:.4f}")

    model_lora.save_pretrained("./test_lora_save")
    loaded_model = PeftModel.from_pretrained(tiny_model, "./test_lora_save")
    print("  [OK] LoRA save/load ok")

    import shutil
    shutil.rmtree("./test_output", ignore_errors=True)
    shutil.rmtree("./test_lora_save", ignore_errors=True)

except Exception as e:
    print(f"  [FAIL] flow error: {e}")
    import traceback
    traceback.print_exc()
    sys.exit(1)

print("\n" + "=" * 50)
print("ALL TESTS PASSED")
print("=" * 50)
