from hyperon import MeTTa

# Load MeTTa knowledge base
metta = MeTTa()
try:
    with open("recipes.metta", "r") as file:
        metta.run(file.read())
except FileNotFoundError:
    print("Error: recipes.metta file not found.")
    exit()

def find_recipes(ingredients, dietary=None):
    # Get all recipes using match
    query = "!(match &self (isa $recipe Recipe) $recipe)"
    result = metta.run(query)
    print("All recipes (raw result):", result)
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
                formatted_name = recipe.replace('With', ' with ').replace('And', ' and ')
                matching_recipes.append((formatted_name, cooking_time))
    
    return matching_recipes

def process_input(user_input):
    # Simple parsing for ingredients and dietary restrictions
    input_lower = user_input.lower()
    
    # Extract ingredients
    ingredients = []
    for ing in ['tomato', 'pasta', 'cheese', 'chicken', 'rice', 'onion', 'garlic']:
        if ing in input_lower:
            ingredients.append(ing.capitalize())
    
    # Extract dietary restriction
    dietary = None
    for diet in ['vegetarian', 'vegan', 'glutenfree']:
        if diet in input_lower:
            dietary = diet.capitalize()
            break
    
    if not ingredients:
        return "Sorry, I couldn't identify any ingredients in your input."
    
    # Find matching recipes
    recipes = find_recipes(ingredients, dietary)
    
    if not recipes:
        return "No recipes found with those ingredients" + (f" and {dietary} restriction." if dietary else ".")
    
    # Format output
    response = "You can make:\n"
    for recipe_name, cooking_time in recipes:
        response += f"- {recipe_name}. Cooking time: {cooking_time} minutes\n"
    return response

# Test the bot
user_input = "I have tomato and want something vegan"
print(process_input(user_input))