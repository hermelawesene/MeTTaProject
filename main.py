from hyperon import MeTTa

metta = MeTTa()
with open("recipes.metta") as file:
    metta.run(file.read())



# Simple ingredient extraction
def get_ingredients(text):
    ingredients = ["Tomato", "Pasta", "Cheese", "Chicken", "Rice", "Onion", "Garlic"]
    return [ing for ing in ingredients if ing.lower() in text.lower()]


def find_recipes(ingredients):
    # Get all recipes using match
    query = "!(match &self (isa $recipe Recipe) $recipe)"
    result = metta.run(query)
    print("All recipes (raw result):", result)  # Match your first method
    all_recipes = [str(atom) for atom in result[0]] if result and result[0] else []
    
    matching_recipes = []
    for recipe in all_recipes:
        # Check if recipe has all ingredients
        has_all_ingredients = True
        for ingredient in ingredients:
            query = f"!(match &self (hasIngredient {recipe} {ingredient}) {ingredient})"
            result = metta.run(query)
            if not (result and result[0] and ingredient in str(result[0])):
                has_all_ingredients = False
                break
        if has_all_ingredients:
            # Get cooking time
            query = f"!(match &self (cookingTime {recipe} $time) $time)"
            result = metta.run(query)
            print(f"Cooking time for {recipe} (raw result):", result)
            cooking_time = int(str(result[0][0])) if result and result[0] else None
            if cooking_time is not None:
                formatted_name = recipe.replace('With', ' with ').replace('And', ' and ')
                matching_recipes.append((formatted_name, cooking_time))
    
    return matching_recipes

def process_input(user_input):
    # Simple parsing (simulates LLM)
    input_lower = user_input.lower()
    ingredients = []
    for ing in ['tomato', 'pasta', 'cheese', 'chicken', 'rice', 'onion', 'garlic']:
        if ing in input_lower:
            ingredients.append(ing.capitalize())  # Match MeTTa symbol case
    
    if not ingredients:
        return "Sorry, I couldn't identify any ingredients in your input."
    
    # Find matching recipes
    recipes = find_recipes(ingredients)
    if not recipes:
        return "No recipes found with those ingredients."
    
    # Format output
    response = "You can make:\n"
    for recipe_name, cooking_time in recipes:
        response += f"- {recipe_name}. Cooking time: {cooking_time} minutes\n"
    return response

# Test the bot
user_input = "I have Tomato, Pasta, and Cheese. What can I cook?"
print(process_input(user_input))

#I have Chicken, Rice, Garlic and Onion. What can I cook?