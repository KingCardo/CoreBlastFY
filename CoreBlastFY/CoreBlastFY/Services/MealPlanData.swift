//
//  MealPlanData.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/26/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

// Meal Plans

//shredded - gains - vegan - franchiz

let allMPs = [shreddedMP, gainsMP, veganMP, franchizMP, mockMP1]

//Shredded MP
//Breakfast Ingredients
let eggs = Recipe.Ingredient(name: "Eggs", amount: "3")
let sausage = Recipe.Ingredient(name: "Turkey Sausage", amount: "3")
let water = Recipe.Ingredient(name: "Water", amount: "16oz")
let banana = Recipe.Ingredient(name: "Banana", amount: "1")
let extraVirginOliveOil = Recipe.Ingredient(name: "Extra virgin olive oil", amount: "")


let shreddedBkInstructions: [String] = ["Preheat skillet over medium heat", "Once skillet is hot, add oil to pan evenly", "Cook sausage while rotating sides every 1-2 minutes until golden brown", "Boil water in seperate pot", "Add eggs and let boil for 10 minutes", "Dump hot water out and run cold water over eggs until cool enough to peel shells", "Slice and serve eggs with salt and pepper"]
let shreddedBreakfastIngredients: [Recipe.Ingredient] = [eggs, sausage, banana, extraVirginOliveOil, salt]
let shreddedBreakastName = "Eggs and Sausage"

//lunch
//Lunch Ingredients
let spinach = Recipe.Ingredient(name: "Spinach", amount: "5oz")
let cilantro = Recipe.Ingredient(name: "Cilantro", amount: "")
let chickenBreast = Recipe.Ingredient(name: "Chicken Breast", amount: "1/2 lb")
let cucumber = Recipe.Ingredient(name: "Cucumber", amount: "1/2")

let shreddedLunchInstructions: [String] = ["Heat a skillet over medium-high heat.", "Season chicken with olive oil and salt, pepper and your favorite chicken seasoning.", "Add oil to skillet and coat evenly. Add chicken and cook thoroughly flipping every 2-3 minutes until browned. Transfer to a plate.", "Wash veggies", "Slice cucumber into slices, and chop up cilantro.", "Add spinach to a bowl or plate along with cilantro and cucumbers.", "Slice chicken into small pieces and add on top.", "Serve with lemon juice and your choice of dressing."]
let shreddedLunchIngredients: [Recipe.Ingredient] = [spinach, cilantro, chickenBreast, cucumber, extraVirginOliveOil, salt]
let shreddedLucnhName = "Chicken Spinach Salad"


//dinner

let broccoli = Recipe.Ingredient(name: "Broccoli", amount: "Half plate")
let salmon = Recipe.Ingredient(name: "Salmon filet", amount: "3/4 lb")
let salt = Recipe.Ingredient(name: "Salt", amount: "")
let garlic = Recipe.Ingredient(name: "Garlic Powder", amount: "")
let onionPowder = Recipe.Ingredient(name: "Onion Powder", amount: "")
let pepper = Recipe.Ingredient(name: "Black Pepper", amount: "")


let shreddedDinnerInstructions: [String] = ["Preheat oven to 425 F.", " Drizzle broccoli with olive oil, salt, pepper, and onion powder.", "Spread veggies on aluminum foil on baking sheet in single layer.", "Place the salmon fillets, skin-side down, rub with olive oil and season with salt, pepper, garlic and onion powder.", "Place on cooking sheet with aluminum foil and bae until salmon is opaque and broccoli is tender, 12-18 minutes.", "Transfer food to plate and enjoy!"]
let shreddedDinnerIngredients: [Recipe.Ingredient] = [broccoli, extraVirginOliveOil, salmon, salt, garlic, onionPowder, pepper]
let shreddedDinnerName = "Roasted Salmon & Veggies"

//snack
let almondMilk = Recipe.Ingredient(name: "Almond Milk", amount: "8 oz")
let berries = Recipe.Ingredient(name: "Frozen Berries(strawberry,blueberry)", amount: "3 oz")
let mango = Recipe.Ingredient(name: "Frozen diced mango", amount: "2 oz")
let shreddedSnackInstructions: [String] = ["Add all ingredients to blender.", "Blend on high until smooth.", "Pour smoothie into a glass and enjoy!"]
let shreddedSmoothieIngredients: [Recipe.Ingredient] = [almondMilk, banana, berries, mango]
let shreddedSnackName = "Fruit Smoothie"

//dinner2
let avocado = Recipe.Ingredient(name: "Avocado", amount: "1")
let lettuce = Recipe.Ingredient(name: "Butter Lettuce", amount: "1 head")
let tuna = Recipe.Ingredient(name: "Chunk tuna light in water", amount: "2 (6oz) cans")
let lime = Recipe.Ingredient(name: "Lime juice", amount: "")
let redOnion = Recipe.Ingredient(name: "Red onion", amount: "1/2 medium")
let mayo = Recipe.Ingredient(name: "Avocado oil mayonnaise", amount: "")


let shreddedDinner2Instructions: [String] = ["Clean and dry lettuce. Seperating them into leaves.", "Drain the tuna and transfer to a large sald bowl.", "Using a knife, dice onion and cilantro to tiny pieces.","Add 3 tbsp of mayo, salt, pepper, lime juice, onion, and cilantro to tuna and stir thoroughly.", "Slice avocado." , "Make lettuce wraps by spooning tuna sald into lettuce leaves, and garnish with avocida slice, enjoy!"]
let shreddedDinner2Ingredients: [Recipe.Ingredient] = [avocado, lettuce, tuna, lime, redOnion, mayo, salt, pepper]
let shreddedDinner2Name = "Tuna Salad Wraps"

let shreddedBreakfastRecipe = Recipe(name: shreddedBreakastName, ingredients: shreddedBreakfastIngredients, instructions: shreddedBkInstructions, mealType: Recipe.MealType.breakfast, image: #imageLiteral(resourceName: "mp1image"))

let shreddedLunchRecipe = Recipe(name: shreddedLucnhName, ingredients: shreddedLunchIngredients, instructions: shreddedLunchInstructions, mealType: Recipe.MealType.lunch, image: #imageLiteral(resourceName: "mp1image"))

let shreddedSnackRecipe = Recipe(name: shreddedSnackName, ingredients: shreddedSmoothieIngredients, instructions: shreddedSnackInstructions, mealType: Recipe.MealType.snack, image: #imageLiteral(resourceName: "mp2image"))

let shreddedDinnerRecipe = Recipe(name: shreddedDinnerName, ingredients: shreddedDinnerIngredients, instructions: shreddedDinnerInstructions, mealType: Recipe.MealType.dinner, image: #imageLiteral(resourceName: "mp1image"))

let shreddedDinner2Recipe = Recipe(name: shreddedDinner2Name, ingredients: shreddedDinner2Ingredients, instructions: shreddedDinner2Instructions, mealType: Recipe.MealType.dinner2, image: #imageLiteral(resourceName: "mp1image"))

let shreddedMealPlanTitle = "Super Shred"
let shreddedMealPlanSummary = "Accelerate your gains with this fat burning plan!"
let shreddedMealDescription = "Chisel up the nutritious way!"
let shreddedMealTip = "Meal prep a couple days at a time to make sure your ahead of schedule"

let shreddedMP = MealPlan(title: shreddedMealPlanTitle,
                          summary: shreddedMealPlanSummary,
                          description: shreddedMealDescription,
                          image: #imageLiteral(resourceName: "mp2image"),
                          breakfast: shreddedBreakfastRecipe,
                          lunch: shreddedLunchRecipe,
                          dinner: shreddedDinnerRecipe,
                          snack: shreddedSnackRecipe,
                          dinner2: shreddedDinner2Recipe,
                          tip: shreddedMealTip)

//Gains meal plan
//breakfast
let brownRiceWrap = Recipe.Ingredient(name: "Brown Rice Tortilla", amount: "2")

let gainsBkInstructions: [String] = ["Preheat skillet over medium heat", "Once skillet is hot, add oil to pan evenly", "Cook sausage while rotating sides every 1-2 minutes until golden brown", "Transfer sausage to a plate.", "Add more oil to pot, and scramble eggs adding salt and pepper", "Once eggs are cooked your your preference add sausage and eggs to a torilla", "Add jelly or salsa for extra flavor, enjoy!"]
let gainsBreakfastIngredients: [Recipe.Ingredient] = [brownRiceWrap, eggs, sausage, banana, extraVirginOliveOil, salt]
let gainsBreakastName = "Eggs and Sausage Wrap"

//lunch

let sweetPotato = Recipe.Ingredient(name: "Large sweet potato", amount: "1")
let beefPatty = Recipe.Ingredient(name: "Lean ground beef", amount: "3/4 lb")
let coconutOil = Recipe.Ingredient(name: "Coconut oil", amount: "1/2tbsp")


let gainslunchInstructions: [String] = ["Preheat oven to 425F.", "Cut sweet potato into slices(preferred for eatin).", "Place sliced sweet potatos on aluminum foil on sheet pan, drizzle with olive oil, salt and pepper, arranged in a single layer.", "Place sweet potatos in oven and let roast flipping them halfway thru for 20-25 minutes, until tender when pierced with fork.","Add ground beef to a large bowl with salt and pepper. Using your clean hands mix well, and form into two equal patties.", "Preheat a skillet over medium heat with oil.", "Once skillet is hot, add coconut oil to coat evenly.", "Place patties in skillet and cook until browned 2-5 minutes per side(your preference). Transfer to a plate.", "Serve with bbq sauce for fries. Enjoy!"]

let gainsLunchIngredients: [Recipe.Ingredient] = [sweetPotato, beefPatty, salt, extraVirginOliveOil, coconutOil]
let gainsLunchMealName = "Beef Patty with Sweet Potato Fries"
//dinner

let lemonJuice = Recipe.Ingredient(name: "Lemon juice", amount: "1 tbsp")
let brownRice = Recipe.Ingredient(name: "Brown rice", amount: "4 oz")
let blackBeans = Recipe.Ingredient(name: "Black beans", amount: "2 cans")
let corn = Recipe.Ingredient(name: "Canned corn", amount: "1 can")
let water8 = Recipe.Ingredient(name: "Water", amount: "8 oz")


let gainsDinnerInstructions: [String] = ["Combine the oil, garlic powder, salt, and black pepper in a small bowl and stir to combine.", "Place the chicken in a large zip top plastic bag and add the marinade. Zip the bag and mix the chicken into the marinade. Place it into the fridge and let it marinate for at least 1 hour.", "Heat an indoor or outdoor grill to about 400 degrees F (medium high heat). Place the chicken onto the grill and grill 4 to 6 minutes per side, until the chicken is cooked. Remove the chicken from the grill. Chop the chicken into small bite sized pieces and use as needed.", "In a big pot, Add the water and bring the rice to a boil. Cover and reduce the heat to low and cook until the rice is tender and all the water is absorbed.", "Add in the cilantro, lemon juice and fluff rice with a fork.", "Top with equal parts of the heated black beans, heated corn, guacamole, pico and serve immediately. Enjoy!"]

let gainsDinnerIngredients: [Recipe.Ingredient] = [cilantro, brownRice, blackBeans, corn, chickenBreast, salt, lemonJuice, garlic, extraVirginOliveOil, pepper, water8]
let gainsDinnerMealName = "Chipotle Style Bowl"
//dinner2

//snack

let gainsBreakfastRecipe = Recipe(name: gainsBreakastName, ingredients: gainsBreakfastIngredients, instructions: gainsBkInstructions, mealType: Recipe.MealType.breakfast, image: #imageLiteral(resourceName: "mp1image"))

let gainsLunchRecipe = Recipe(name: gainsLunchMealName, ingredients: gainsLunchIngredients, instructions: gainslunchInstructions, mealType: Recipe.MealType.lunch, image: #imageLiteral(resourceName: "mp1image"))

let gainsSnackRecipe = Recipe(name: shreddedSnackName, ingredients: shreddedSmoothieIngredients, instructions: shreddedSnackInstructions, mealType: Recipe.MealType.snack, image: #imageLiteral(resourceName: "mp2image"))

let gainsDinnerRecipe = Recipe(name: gainsDinnerMealName, ingredients: gainsDinnerIngredients, instructions: gainsDinnerInstructions, mealType: Recipe.MealType.dinner, image: #imageLiteral(resourceName: "mp1image"))

let gainsDinner2Recipe = Recipe(name: gainsDinnerMealName, ingredients: gainsDinnerIngredients, instructions: gainsDinnerInstructions, mealType: Recipe.MealType.dinner2, image: #imageLiteral(resourceName: "mp1image"))

let gainsMealPlanTitle = "Gains Galore"
let gainsMealPlanSummary = "This plan lets you gain muscle mass while making six pack gains!"
let gainsMealDescription = "Add on muscle mass in a clean way!"
let gainsMealTip = "Drink lots of water, have to stay hydrated"

let gainsMP = MealPlan(title: gainsMealPlanTitle,
                          summary: gainsMealPlanSummary,
                          description: gainsMealDescription,
                          image: #imageLiteral(resourceName: "nutrition"),
                          breakfast: gainsBreakfastRecipe,
                          lunch: gainsLunchRecipe,
                          dinner: gainsDinnerRecipe,
                          snack: gainsSnackRecipe,
                          dinner2: gainsDinner2Recipe,
                          tip: gainsMealTip)

//Franchiz Meal plan

//lunch

let franchizLunchMealName = "Chicken, Sweet Potato Mash & Veggies"
let franchizLunchIngredients: [Recipe.Ingredient] = [chickenBreast, garlic, salt, pepper, coconutOil, lemonJuice, sweetPotato]
let franchizLunchInstructions: [String] = ["Fill a medium pot about halfway with water, cover, and bring to a boil.", "Wash, peel, and medium dice the sweet potatoes; add to the saucepan. Once the water is boiling, cook until the potatoes are very tender when pierced with a fork, 10-15 minutes. Drain and return to saucepan.", "Heat a skillet over medium heat.", "Slice chicken in half horizontally to form thin fillets. Season both sides with salt, garlic, onion, and pepper(and preferred seasonings).", "Melt coconut oil in the skillet. Add the chicken and cook until golden brown and cooked through, 4-5 minutes per side. Transfer to a plate.", "Add more coconut oil to the skillet, followed by the kale. Cook, stirring occasionally, until bright green and tender-crisp, 2-3 minutes. Season with salt and pepper and remove from heat.", "Add the remaining coconut oil to the potatoes and season with cinnamon, salt and brown sugar. Mash with a potato masher (or a fork) until smooth.", "Place the mashed potatoes, kale, and chicken on a plate. Enjoy!"]

//dinner

//dinner2

//snack

let apple = Recipe.Ingredient(name: "Water", amount: "1")
let almonds = Recipe.Ingredient(name: "Salted Almonds", amount: "3 oz")


let franchizSnackInstructions: [String] = [""]

let franchizSnackIngredients: [Recipe.Ingredient] = [banana, almonds, apple]
let franchizSnackMealName = "Fruit & Almonds"

let franchizBreakfastRecipe = Recipe(name: shreddedSnackName, ingredients: shreddedSmoothieIngredients, instructions: gainsBkInstructions, mealType: Recipe.MealType.breakfast, image: #imageLiteral(resourceName: "mp1image"))

let franchizLunchRecipe = Recipe(name: franchizLunchMealName, ingredients: franchizLunchIngredients, instructions: franchizLunchInstructions, mealType: Recipe.MealType.lunch, image: #imageLiteral(resourceName: "mp1image"))

let franchizSnackRecipe = Recipe(name: franchizSnackMealName, ingredients: franchizSnackIngredients, instructions: franchizSnackInstructions, mealType: Recipe.MealType.snack, image: #imageLiteral(resourceName: "mp2image"))

let franchizDinnerRecipe = Recipe(name: shreddedDinnerName, ingredients: shreddedDinnerIngredients, instructions: shreddedDinnerInstructions, mealType: Recipe.MealType.dinner, image: #imageLiteral(resourceName: "mp1image"))

let franchizDinner2Recipe = Recipe(name: franchizLunchMealName, ingredients: franchizLunchIngredients, instructions: franchizLunchInstructions, mealType: Recipe.MealType.dinner, image: #imageLiteral(resourceName: "mp1image"))

let franchizMealPlanTitle = "Franchiz Personal Plan"
let franchizMealPlanSummary = "This is my current personal meal plan that gives me the balance I need at simplest form."
let franchizMealDescription = "Abs are made in the kitchen! Time to get right!"
let franchizMealTip = "To be successful you have to plan ahead or you will fail! "

let franchizMP = MealPlan(title: franchizMealPlanTitle,
                          summary: franchizMealPlanSummary,
                          description: franchizMealDescription,
                          image: #imageLiteral(resourceName: "inapppromopic"),
                          breakfast: franchizBreakfastRecipe,
                          lunch: franchizLunchRecipe,
                          dinner: franchizDinnerRecipe,
                          snack: franchizSnackRecipe,
                          dinner2: franchizDinner2Recipe,
                          tip: franchizMealTip)


let veganBreakfastRecipe = Recipe(name: shreddedSnackName, ingredients: shreddedSmoothieIngredients, instructions: gainsBkInstructions, mealType: Recipe.MealType.breakfast, image: #imageLiteral(resourceName: "mp1image"))

let veganLunchRecipe = Recipe(name: franchizLunchMealName, ingredients: franchizLunchIngredients, instructions: franchizLunchInstructions, mealType: Recipe.MealType.lunch, image: #imageLiteral(resourceName: "mp1image"))

let veganSnackRecipe = Recipe(name: franchizSnackMealName, ingredients: franchizSnackIngredients, instructions: franchizSnackInstructions, mealType: Recipe.MealType.snack, image: #imageLiteral(resourceName: "mp2image"))

let veganDinnerRecipe = Recipe(name: franchizLunchMealName, ingredients: franchizLunchIngredients, instructions: franchizLunchInstructions, mealType: Recipe.MealType.dinner, image: #imageLiteral(resourceName: "mp1image"))

let veganDinner2Recipe = Recipe(name: franchizLunchMealName, ingredients: franchizLunchIngredients, instructions: franchizLunchInstructions, mealType: Recipe.MealType.dinner, image: #imageLiteral(resourceName: "mp1image"))

let veganMealPlanTitle = "Vegetarian Plan"
let veganMealPlanSummary = "This is a plan for my vegetarian friends"
let veganMealDescription = "Abs are made in the kitchen! Time to get right!"
let veganMealTip = "To be successful you have to plan ahead or you will fail! "

let veganMP = MealPlan(title: veganMealPlanTitle,
                          summary: veganMealPlanSummary,
                          description: veganMealDescription,
                          image: #imageLiteral(resourceName: "inapppromopic"),
                          breakfast: veganBreakfastRecipe,
                          lunch: veganLunchRecipe,
                          dinner: veganDinnerRecipe,
                          snack: veganSnackRecipe,
                          dinner2: veganDinner2Recipe,
                          tip: veganMealTip)

//Individual Meal Plans

let mockMP1 = MealPlan(title: "Tips for Success", summary: "Have no idea what you should be eating? This is for you!",
                        description: "Abs are made in the kitchen! Time to get right!",
                        image: #imageLiteral(resourceName: "mp1image"),
                        tip: "To be successful you have to plan ahead or you will fail! \nNumber 1: meal prep for at least a couple of days at a time, having great food ready to eat is a major key to staying on track. \nNumber 2: drink lots of water, have to stay hydrated. \nNumber 3: make sure to get good sleep every night, your body will thank you. Minimum 7 hours. \nNumber 4: Remember why you started this, and ask how bad do you want it. You have to be discipline, and focused on the end result and be consistent. You're planting a seed, and can't expect the tree to grow overnight. Put in the work and don't cheat yourself and results will come. Last tip: It's ok to mess up, get back up and keep focused, we're human. Were creating a Lifetsyle of good choices in a lot of aspects here so the good will outweigh the bad. Take it one day at a time! Have fun!",
                        whatToAvoid: "What to avoid is just as important to efficiently get to your goals! Think again in types, which are sugars, flours, fatty fried foods. So all the processed junk has to go : candy, fastfood, alcohol, bread, tortillas, chips, soda, dairy.",
                        whatToEat: "What you eat is the 1st and most important part of this program. Over the 12 weeks we will build great habits that will enable your success for continual improvement. With that in mind, you have lots of options as long as you think in types. Proteins, Veggies, Fruits, Complex Carbs. Proteins can include, eggs, chicken, fish, steak, tofu, and ground beef. With veggies, take your pick and eat lots of them, examples are kale, spinach, broccoli, avocados, peppers, zuchini, and cucumbers. Fruits are great for snacks and smoothies, all types of berries, bananas, apples. When making smoothies with fruit with extra sugar like mangos or pineapple make sure half of the contents is a green superfood for slower absorption. Complex carbs are great fillers which include, brown rice, quinoa, old fashined oatmeal, lentils, beans, and sweet potatoes. Snacks are good for nuts, seeds and more fruits and veggies.",
                        guidelines: "Here is a sample of meal ideas to help you if have no clue how to structure meals. \nBreakfast: Smoothie with kale, banana, berries, almond milk. \nSnack : almonds and apple or cucumbers. \nLunch: Salad with tuna and eggs or your favortie protein. \nDinner: Roasted chicken, with favorite veggie and brown rice.",
                        isTips: true)

