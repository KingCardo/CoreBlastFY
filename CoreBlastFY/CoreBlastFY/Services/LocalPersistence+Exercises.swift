//
//  LocalPersistence+Exercises.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

let coreBeginnerKey = "beginner"
let coreNoviceKey = "novice"
let coreSolidKey = "solid"
let coreAdvancedKey = "advanced"
let coreRockstarKey = "rockstar"

class ExerciseStorage {
    
    static var failedCompletion: ((String) -> Void)?
    
    static var exercises: [Exercise] = [] {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("ExercisesLoadedNotification"), object: self)
            }
        }
    }
    
    static func save() {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("Exercises").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        
        do {
            let encodedData = try jsonEncoder.encode(exercises)
            try encodedData.write(to: archiveURL)
        } catch let error {
            print(error)
        }
        
    }
    @discardableResult
    static func loadExercises() -> Bool {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("Exercises").appendingPathExtension("json")
        
        let jsonDecoder = JSONDecoder()
        guard let decodedData = try? Data(contentsOf: archiveURL) else { return false }
        
        do {
            self.exercises = try jsonDecoder.decode([Exercise].self, from: decodedData)
            return exercises.count > 0 ? true : false
        } catch {
            return false
        }
    }
    
    static func fetchExercises(with level: String) {
        if !UserDefaults.standard.bool(forKey: level) {
            let worker = ExerciseWorker(exerciseInfoDataStore: CloudKitService())
            worker.fetchExercises(of: level) { (exercises, error) in
                if !exercises.isEmpty {
                    ExerciseStorage.exercises += exercises
                    ExerciseStorage.save()
                    UserDefaults.standard.set(true, forKey: level)
                } else {
                    ExerciseStorage.failedCompletion?(error!.localizedDescription)
                    
                }
            }
        }
    }
    
    static func fetchCoreExercises() {
         ExerciseStorage.loadExercises()
         let user = UserManager.loadUserFromFile()

        switch user.totalPoints {
        case 0: ExerciseStorage.fetchExercises(with: "beginner")
        case 14: ExerciseStorage.fetchExercises(with: "novice")
        case 29: ExerciseStorage.fetchExercises(with: "solid")
        case 44: ExerciseStorage.fetchExercises(with: "advanced")
        case 59: ExerciseStorage.fetchExercises(with: "rockstar")
        default: break
        }
    }
}
