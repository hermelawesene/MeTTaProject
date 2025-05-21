from transformers import pipeline

model = pipeline("text-generation", model ="distilgpt2")
response = model("What are the plants?", max_length=50, truncation=True, num_return_sequences=1)
print(response)