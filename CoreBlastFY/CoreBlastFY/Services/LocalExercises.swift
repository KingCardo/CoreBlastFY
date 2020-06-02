//
//  LocalExercises.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 6/1/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

struct LocalExercises: ExerciseInfoStoreProtocol {
    func fetchExercises(completion: @escaping ([Exercise], ExerciseInfoStoreError?) -> Void) {
        completion(LocalExercises.exercises, nil)
        return
    }
    
 
    static let exercises: [Exercise] = [leftSidePlankWrap, rightSidePlankWrap, legRaises, leftSidePlankHD, rightSidePlankHD, inOuts, openClose, pendulums, dynamicDeadbug,  reversePlank, squatJumps, pushupTPlank, leftSidePlank, rightSidePlank, sLegToeTouchLeft, sLegToeTouchRight, plankWTap, openCloseASkip, inoutsAdvanced, updog, plank, tPlank, kneeDrives, ironMikes]

}

//Exercises
let leftSidePlankWrap = Exercise(name: "left side plank wrap", tip: "squeeze lower oblique", level: .solid, movement: .dynamic)
let rightSidePlankWrap = Exercise(name: "right side plank wrap", tip: "squeeze lower oblique", level: .solid, movement: .dynamic)
let legRaises = Exercise(name: "leg raises", tip: "slow controlled movement", level: .beginner, movement: .dynamic)
let leftSidePlankHD = Exercise(name: "left side plank hipdip", tip: "squeeze lower oblique", level: .novice, movement: .dynamic)
let rightSidePlankHD = Exercise(name: "right side plank hipdip", tip: "squeeze lower oblique", level: .novice, movement: .dynamic)
let inOuts = Exercise(name: "in outs", tip: "engage core", level: .novice, movement: .dynamic)
let openClose = Exercise(name: "open close", tip: "slow under controll", level: .novice, movement: .dynamic)
let pendulums = Exercise(name: "pendulums", tip: "slow and under control, core engaged", level: .advanced, movement: .dynamic)
let dynamicDeadbug = Exercise(name: "dynamic deadbug", tip: "keep back flat", level: .beginner, movement: .dynamic)
let reversePlank = Exercise(name: "reverse plank", tip: "core engaged, keep back flat", level: .beginner, movement: .stationary)
let squatJumps = Exercise(name: "squat jumps", tip: "explode up, land softly", level: .rockstar, movement: .dynamic)
let pushupTPlank = Exercise(name: "pushup t plank", tip: "slow and under control", level: .rockstar, movement: .dynamic)
let leftSidePlank = Exercise(name: "left side plank", tip: "engage lower oblique", level: .beginner, movement: .stationary)
let rightSidePlank = Exercise(name: "right side plank", tip: "engage lower oblique", level: .beginner, movement: .stationary)
let sLegToeTouchLeft = Exercise(name: "single leg toe touch left", tip: "maintain balance", level: .advanced, movement: .dynamic)
let sLegToeTouchRight = Exercise(name: "single leg toe touch right", tip: "maintain balance", level: .advanced, movement: .dynamic)
let plankWTap = Exercise(name: "plank shoulder tap", tip: "slow controlled movements - breathe", level: .novice, movement: .dynamic)
let openCloseASkip = Exercise(name: "open close a skip", tip: "slow controlled movements", level: .solid, movement: .dynamic)
let inoutsAdvanced = Exercise(name: "in outs advanced", tip: " nice deep breathes", level: .advanced, movement: .dynamic)
let updog = Exercise(name: "up dog", tip: "breathe", level: .beginner, movement: .stationary)
let plank = Exercise(name: "plank", tip: "engage core", level: .beginner, movement: .stationary)
let tPlank = Exercise(name: "t plank", tip: "core engaged - deep breathes", level: .solid, movement: .dynamic)
let kneeDrives =  Exercise(name: "kneedrives", tip: "nice and slow", level: .solid, movement: .dynamic)
let ironMikes = Exercise(name: "iron mikes", tip: "explode up, land softly", level: .rockstar, movement: .dynamic)








