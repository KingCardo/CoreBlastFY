//
//  MealPlanAPI.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/17/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

class MealPlanAPI: GetPlansOverviewStore {
    
    var mealPlans: [MealPlan] = allMPs
    
    func fetchPlansOverview(completion: @escaping ([MealPlan], GetPlansOverviewStoreError?) -> Void) {
        completion(mealPlans, nil)
    }
}


let mockMP1 = MealPlan(title: "Tips for Success", summary: "Have no idea what you should be eating? This is for you!", imageData: Data(), description: "ngiorjgi;rgi;dng;irngi;rngirng'nkergner'kgnerglnergk/regnerkgng")

let mockMP2 = MealPlan(title: "Shredded Meal Plan", summary: "Accelerate your gains with this fat burning plan!", imageData: Data(), description: "frfn;ewnfiwr;ngiergnreignrelkgnre;gnerlkngrkgegerkgnekgrg ejrg ")

let mockMP3 = MealPlan(title: "Gain while Chisel", summary: "This plan lets you gain muscle mass while making six pack gains!", imageData: Data(), description: "efbefbrlf;fner;fnkfneknferknfkerfnkerfkr")

let mockMP4 = MealPlan(title: "Franchiz Personal Plan", summary: "This is my current meal plan for the maintenance phase when you get where you want to be!", imageData: Data(), description: "rfjnrfnrengekrgergm;krngjer;gje;rbbgerjgerbjg")

let allMPs = [mockMP1, mockMP2, mockMP3, mockMP4]
