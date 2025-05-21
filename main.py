from hyperon import MeTTa
from transformers import pipeline
import re

# Initialize DistilGPT-2 LLM
try:
    llm = pipeline("text-generation", model="distilgpt2")
except Exception as e:
    print(f"Error loading DistilGPT-2: {e}")
    exit()


metta = MeTTa()
with open("recipes.metta") as file:
    metta.run(file.read())

def find_recipes(ingredients, dietary=None):
    # Get all recipes using match
    query = "!(match &self (isa $recipe Recipe) $recipe)"
    result = metta.run(query)
    print("All recipes (raw result):", result)  # Match your first method
    all_recipes = [str(atom) for atom in result[0]] if result and result[0] else []
    
    matching_recipes = []
    for recipe in all_recipes:
        # Check if recipe has all ingredients
        has_all_ingredients = True
        recipe_ingredients = []
        for ingredient in ingredients:
            query = f"!(match &self (hasIngredient {recipe} {ingredient}) {ingredient})"
            result = metta.run(query)
            if not (result and result[0] and ingredient in str(result[0])):
                has_all_ingredients = False
                break
            recipe_ingredients.append(ingredient.lower())
        # Check dietary restriction if specified
        meets_dietary = True
        if dietary and has_all_ingredients:
            query = f"!(match &self (meetsDietaryRestriction {recipe} {dietary}) {dietary})"
            result = metta.run(query)
            if not (result and result[0] and dietary in str(result[0])):
                meets_dietary = False
        if has_all_ingredients and meets_dietary:
            # Get cooking time
            query = f"!(match &self (cookingTime {recipe} $time) $time)"
            result = metta.run(query)
            print(f"Cooking time for {recipe} (raw result):", result)
            cooking_time = int(str(result[0][0])) if result and result[0] else None
            if cooking_time is not None:
                formatted_name = recipe.replace('With', ' with ').replace('And', ' and ').replace('ChickenFriedRice', 'Chicken Fried Rice').replace('TomatoSalad', 'Tomato Salad')
                matching_recipes.append((formatted_name, cooking_time, recipe_ingredients))
    
    return matching_recipes

def generate_recipe_description(recipe_name, ingredients):
    # Prompt for DistilGPT-2, inspired by provided example
    ingredients_str = ", ".join(ingredients)
    prompt = f"""
    RECIPE FORMAT:
    NAME: {recipe_name}
    INGREDIENTS:
    - {ingredients[0] if ingredients else 'Unknown'}
    {f'- {ingredients[1]}' if len(ingredients) > 1 else ''}
    STEPS:
    1) [Step1]
    2) [Step2]
    Generate a recipe using {ingredients_str}:
    """
    
    try:
        # Generate text with DistilGPT-2
        result = llm(
            prompt,
            max_new_tokens=150,
            temperature=0.5,
            repetition_penalty=1.3,
            truncation=True
        )[0]['generated_text']
        # Extract the recipe portion (remove prompt echo)
        recipe_text = result[len(prompt):].strip() if result.startswith(prompt) else result.strip()
        # Ensure output follows the format
        if not recipe_text.startswith("NAME:"):
            recipe_text = f"NAME: {recipe_name}\nINGREDIENTS:\n" + "\n".join(f"- {ing}" for ing in ingredients) + "\nSTEPS:\n" + recipe_text
        return recipe_text
    except Exception as e:
        print(f"LLM generation error for {recipe_name}: {e}")
        # Fallback to basic format
        return f"NAME: {recipe_name}\nINGREDIENTS:\n" + "\n".join(f"- {ing}" for ing in ingredients) + "\nSTEPS:\n1) [Prepare ingredients]\n2) [Cook as per standard recipe]"

def parse_input_keyword(user_input):
    input_lower = user_input.lower()
    ingredients = []
    synonyms = {
        'tomatoes': 'Tomato', 'noodles': 'Pasta', 'cheeses': 'Cheese',
        'onions': 'Onion', 'garlics': 'Garlic', 'rices': 'Rice', 'chickens': 'Chicken',
        'oliveoil': 'OliveOil', 'Basil': 'Basil', 'pepper': 'Pepper', 'carrots': 'Carrot',
        'soyasauce': 'SoyaSauce'
    }
    for word, ingredient in synonyms.items():
        if word in input_lower and ingredient not in ingredients:
            ingredients.append(ingredient)
    for ing in ['tomato', 'pasta', 'cheese', 'chicken', 'rice', 'onion', 'garlic', 'olive oil', 'basil', 'pepper', 'carrot', 'soysauce']:
        if ing in input_lower and ing.capitalize() not in ingredients:
            ingredients.append(ing.capitalize())
    dietary = None
    for diet in ['vegetarian', 'vegan', 'glutenfree']:
        if diet in input_lower:
            dietary = diet.capitalize()
            break
    return ingredients, dietary


def process_input(user_input):
    # Parse input using rule-based parsing
    ingredients, dietary = parse_input_keyword(user_input)
    
    if not ingredients:
        return "Sorry, I couldn't identify any valid ingredients in your input."
    
    # Find matching recipes
    recipes = find_recipes(ingredients, dietary)
    if not recipes:
        return "No recipes found with those ingredients" + (f" and {dietary} restriction." if dietary else ".")
    
     # Format output with LLM-generated recipes
    response = "You can make:\n"
    for recipe_name, cooking_time, recipe_ingredients in recipes:
        response += f"- {recipe_name}. Cooking time: {cooking_time} minutes\n"
        # Generate detailed recipe with LLM
        recipe_description = generate_recipe_description(recipe_name, recipe_ingredients)
        response += f"{recipe_description}\n\n"
    return response

# Test the bot
user_input = input("enter your prompt ")
print(process_input(user_input))

#I have Chicken, Rice, Garlic and Onion. What can I cook?