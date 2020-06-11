//
//  LocalExercises.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 6/11/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

struct LocalExercises: ExerciseInfoStoreProtocol {
    func fetchExercises(completion: @escaping ([Exercise], ExerciseInfoStoreError?) -> Void) {
        completion(LocalExercises.exercises, nil)
        return
    }
    static let exercises: [Exercise] = [reversePlank, legRaises, openClose, pendulums, tPlank]
}

//Exercises
let legRaises = Exercise(name: "leg raises", tip: "slow controlled movement", level: .beginner, movement: .dynamic)
let openClose = Exercise(name: "open close", tip: "slow under controll", level: .novice, movement: .dynamic)
let pendulums = Exercise(name: "pendulums", tip: "slow and under control, core engaged", level: .advanced, movement: .dynamic)
let reversePlank = Exercise(name: "reverse plank", tip: "core engaged, keep back flat", level: .beginner, movement: .stationary)
let tPlank = Exercise(name: "t plank", tip: "core engaged - deep breathes", level: .solid, movement: .dynamic)

