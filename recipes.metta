; Define ingredients
(isa Tomato Ingredient)
(isa Pasta Ingredient)
(isa Cheese Ingredient)
(isa Chicken Ingredient)
(isa Rice Ingredient)
(isa Onion Ingredient)
(isa Garlic Ingredient)

; Define dietary categories
(isa Vegetarian DietaryRestriction)
(isa Vegan DietaryRestriction)
(isa GlutenFree DietaryRestriction)

; Define recipes
(isa PastaWithTomatoAndCheese Recipe)
(isa ChickenFriedRice Recipe)
(isa TomatoSalad Recipe)

; Recipe ingredients
(hasIngredient PastaWithTomatoAndCheese Pasta)
(hasIngredient PastaWithTomatoAndCheese Tomato)
(hasIngredient PastaWithTomatoAndCheese Cheese)

(hasIngredient ChickenFriedRice Chicken)
(hasIngredient ChickenFriedRice Rice)
(hasIngredient ChickenFriedRice Onion)
(hasIngredient ChickenFriedRice Garlic)

(hasIngredient TomatoSalad Tomato)
(hasIngredient TomatoSalad Onion)

; Cooking times in minutes
(cookingTime PastaWithTomatoAndCheese 20)
(cookingTime ChickenFriedRice 30)
(cookingTime TomatoSalad 10)

; Dietary restrictions
(meetsDietaryRestriction PastaWithTomatoAndCheese Vegetarian)
(meetsDietaryRestriction TomatoSalad Vegetarian)
(meetsDietaryRestriction TomatoSalad Vegan)
(meetsDietaryRestriction ChickenFriedRice GlutenFree)