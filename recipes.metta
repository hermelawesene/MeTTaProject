; Define ingredients
(isa Tomato Ingredient)
(isa Pasta Ingredient)
(isa Cheese Ingredient)
(isa Chicken Ingredient)
(isa Rice Ingredient)
(isa Onion Ingredient)
(isa Garlic Ingredient)
(isa OliveOil Ingredient) 
(isa Basil Ingredient) 
(isa Pepper Ingredient) 
(isa Carrot Ingredient) 
(isa SoySauce Ingredient)

; Define dietary categories
(isa Vegetarian DietaryRestriction)
(isa Vegan DietaryRestriction)
(isa GlutenFree DietaryRestriction)

; Define recipes
(isa PastaWithTomatoAndCheese Recipe)
(isa ChickenFriedRice Recipe)
(isa TomatoSalad Recipe)
(isa VegetarianPasta Recipe) 
(isa VeganStirFry Recipe) 
(isa GlutenFreeSalad Recipe)

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

(hasIngredient VegetarianPasta Pasta) 
(hasIngredient VegetarianPasta Tomato) 
(hasIngredient VegetarianPasta Basil) 
(hasIngredient VegetarianPasta OliveOil)

(hasIngredient VeganStirFry Rice) 
(hasIngredient VeganStirFry Carrot) 
(hasIngredient VeganStirFry Onion) 
(hasIngredient VeganStirFry SoySauce)

(hasIngredient GlutenFreeSalad Tomato) 
(hasIngredient GlutenFreeSalad Basil) 
(hasIngredient GlutenFreeSalad OliveOil)

; Cooking times in minutes
(cookingTime PastaWithTomatoAndCheese 20)
(cookingTime ChickenFriedRice 30)
(cookingTime TomatoSalad 10)
(cookingTime VegetarianPasta 25) 
(cookingTime VeganStirFry 20) 
(cookingTime GlutenFreeSalad 15)

; Dietary restrictions
(meetsDietaryRestriction PastaWithTomatoAndCheese Vegetarian)
(meetsDietaryRestriction TomatoSalad Vegetarian)
(meetsDietaryRestriction TomatoSalad Vegan)
(meetsDietaryRestriction ChickenFriedRice GlutenFree)
(meetsDietaryRestriction VegetarianPasta Vegetarian) 
(meetsDietaryRestriction VegetarianPasta Vegan) 
(meetsDietaryRestriction VeganStirFry Vegan) 
(meetsDietaryRestriction VeganStirFry GlutenFree) 
(meetsDietaryRestriction GlutenFreeSalad Vegetarian) 
(meetsDietaryRestriction GlutenFreeSalad Vegan) 
(meetsDietaryRestriction GlutenFreeSalad GlutenFree)