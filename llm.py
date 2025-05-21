from transformers import pipeline

llm = pipeline("text2text-generation", model="flax-community/t5-recipe-generation")

prompt = """RECIPE FORMAT:
NAME: [Name]
INGREDIENTS: 
- [Item1]
- [Item2] 
STEPS:
1) [Step1]
2) [Step2]

Generate using tomatoes and pasta:"""

response = llm(
    prompt,
    max_new_tokens=150,
    temperature=0.5,
    repetition_penalty=1.3
)

print(response[0]["generated_text"])