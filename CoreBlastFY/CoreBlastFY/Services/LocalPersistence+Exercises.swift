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
let exerciseLoadedNotification = NSNotification.Name("ExercisesLoadedNotification")

class ExerciseStorage {
    
    static var failedCompletion: ((String) -> Void)?
    static var succeedCompletion: (() -> Void)?
    
    static var exercises: [Exercise] = [] {
        didSet {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: exerciseLoadedNotification, object: self)
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
    
    static func fetchExercises(completion: @escaping(Bool) -> Void) {
        if !UserDefaults.standard.bool(forKey: exercisesLoaded) {
            let worker = ExerciseWorker(exerciseInfoDataStore: LocalExercises())
            worker.fetchExercises { (exercises, error) in
                if !exercises.isEmpty {
                    ExerciseStorage.exercises += exercises
                    ExerciseStorage.save()
                    UserDefaults.standard.set(true, forKey: exercisesLoaded)
                    completion(true)
                    return
                } else {
                    completion(false)
                    return
                }
            }
        }
    }
    
    static func fetchCoreExercises(completion: @escaping(Bool) -> Void){
        ExerciseStorage.fetchExercises { (success) in
            completion(success)
        }
    }
}
