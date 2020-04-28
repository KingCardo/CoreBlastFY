//
//  MealPlanData.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/26/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

// Meal Plans
let allMPs = [mockMP1, mockMP2, mockMP3, mockMP4]

// Ingredients

let eggs = Recipe.Ingredient(name: "Eggs", amount: "3")
let sausage = Recipe.Ingredient(name: "Tureky Sausage", amount: "3")

// Recipes

let recipe = Recipe(name: "Eggs and Sauage", ingredients: [eggs, sausage], instructions: ["Boil Eggs", "Heat up pan with olive oil", "Cook sausage for 10 minutes over medium heat"], mealType: .breakfast, image: #imageLiteral(resourceName: "nutrition"))

//Individual Meal Plans

let mockMP1 = MealPlan(title: "Tips for Success", summary: "Have no idea what you should be eating? This is for you!",
                        description: "Abs are made in the kitchen! Time to get right!",
                        image: #imageLiteral(resourceName: "mp1image"),
                        tip: "To be successful you have to plan ahead or you will fail! \nNumber 1: meal prep for at least a couple of days at a time, having great food ready to eat is a major key to staying on track. \nNumber 2: drink lots of water, have to stay hydrated. \nNumber 3: make sure to get good sleep every night, your body will thank you. Minimum 7 hours. \nNumber 4: Remember why you started this, and ask how bad do you want it. You have to be discipline, and focused on the end result and be consistent. You're planting a seed, and can't expect the tree to grow overnight. Put in the work and don't cheat yourself and results will come. Last tip: It's ok to mess up, get back up and keep focused, we're human. Were creating a Lifetsyle of good choices in a lot of aspects here so the good will outweigh the bad. Take it one day at a time! Have fun!",
                        whatToAvoid: "What to avoid is just as important to efficiently get to your goals! Think again in types, which are sugars, flours, fatty fried foods. So all the processed junk has to go : candy, fastfood, alcohol, bread, tortillas, chips, soda, dairy.",
                        whatToEat: "What you eat is the 1st and most important part of this program. Over the 12 weeks we will build great habits that will enable your success for continual improvement. With that in mind, you have lots of options as long as you think in types. Proteins, Veggies, Fruits, Complex Carbs. Proteins can include, eggs, chicken, fish, steak, tofu, and ground beef. With veggies, take your pick and eat lots of them, examples are kale, spinach, broccoli, avocados, peppers, zuchini, and cucumbers. Fruits are great for snacks and smoothies, all types of berries, bananas, apples. When making smoothies with fruit with extra sugar like mangos or pineapple make sure half of the contents is a green superfood for slower absorption. Complex carbs are great fillers which include, brown rice, quinoa, old fashined oatmeal, lentils, beans, and sweet potatoes. Snacks are good for nuts, seeds and more fruits and veggies.",
                        guidelines: "Here is a sample of meal ideas to help you if have no clue how to structure meals. \nBreakfast: Smoothie with kale, banana, berries, almond milk. \nSnack : almonds and apple or cucumbers. \nLunch: Salad with tuna and eggs or your favortie protein. \nDinner: Roasted chicken, with favorite veggie and brown rice.")

let mockMP2 = MealPlan(title: "Shredded Meal Plan", summary: "Accelerate your gains with this fat burning plan!",
                       description: "Shredded",
                       image: #imageLiteral(resourceName: "mp2image"),
                       breakfast: recipe,
                       lunch: recipe,
                       dinner: recipe,
                       snack: recipe,
                       dinner2: recipe,
                       tip: "Meal prep a couple days at a time to make sure your ahead of schedule")

let mockMP3 = MealPlan(title: "Gain while Chisel", summary: "This plan lets you gain muscle mass while making six pack gains!",
                       description: "Gains",
                       image: #imageLiteral(resourceName: "nutrition"),
                       breakfast: recipe,
                       lunch: recipe,
                       dinner: recipe,
                       snack: recipe,
                       dinner2: recipe,
                       tip: "")

let mockMP4 = MealPlan(title: "Franchiz Personal Plan", summary: "This is my current personal meal plan for the maintenance phase when you get where you want to be!",
                       description: "Abs are made in the kitchen! Time to get right!",
                       image: #imageLiteral(resourceName: "inapppromopic"),
                       breakfast: recipe,
                       lunch: recipe,
                       dinner: recipe,
                       snack: recipe,
                       dinner2: recipe,
                       tip: "")
