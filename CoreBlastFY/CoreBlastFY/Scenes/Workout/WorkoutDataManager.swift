//
//  WorkoutDataManager.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/10/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation

//let workoutSetNotification = NSNotification.Name("workoutSetNotification")
//
//protocol WorkoutsDataProvider {
//    func fetchAllExercises(completion: @escaping(Bool) -> Void)
//}
//
//final class WorkoutDataManager {
//    static let shared = WorkoutDataManager()
//    var db: Firestore!
//    var storageRef: StorageReference!
//
//    var exercises: [Exercise] = []
//
//    var complete: (() -> Void)?
//
//    func setupDb() {
//        let db = Firestore.firestore()
//        self.db = db
//    }
//
//    func setupStorage() {
//        let storage = Storage.storage()
//        let storRef = storage.reference()
//        self.storageRef = storRef
//    }
//}
//
//extension WorkoutDataManager: WorkoutsDataProvider {
//
//    func fetchAllExercises(completion: @escaping(Bool) -> Void) {
//        db.collection("exercises").getDocuments() { (snapshot, error) in
//            if error != nil {
//                completion(false)
//                return
//            } else {
//                for doc in (snapshot?.documents)! {
//                    let exercise = Exercise(dictionary: doc.data())
//                    self.exercises.append(exercise)
//                }
//                completion(true)
//            }
//        }
//    }
//}
//
//extension WorkoutDataManager {
//
//    func save() {
//
//         let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//         let archiveURL = documentsDirectory.appendingPathComponent("Exercises").appendingPathExtension("json")
//
//         let jsonEncoder = JSONEncoder()
//
//         do {
//             let encodedData = try jsonEncoder.encode(exercises)
//             try encodedData.write(to: archiveURL)
//         } catch let error {
//             print(error)
//         }
//
//     }
//
//     func loadExercises() -> Bool {
//
//         let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//         let archiveURL = documentsDirectory.appendingPathComponent("Exercises").appendingPathExtension("json")
//
//         let jsonDecoder = JSONDecoder()
//        guard let decodedData = try? Data(contentsOf: archiveURL) else { return false }
//
//         do {
//             self.exercises = try jsonDecoder.decode([Exercise].self, from: decodedData)
//            return true
//         } catch let error {
//             print(error)
//            return false
//         }
//     }
//}
