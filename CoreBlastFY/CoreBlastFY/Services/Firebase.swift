////
////  Firebase.swift
////  CoreBlast
////
////  Created by Riccardo Washington on 1/26/20.
////  Copyright © 2020 Riccardo Washington. All rights reserved.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestore
//
//class FireBaseService: ExerciseInfoStoreProtocol {
//    var db: Firestore!
//    var storageRef: StorageReference!
//    
//    var exercises: [Exercise] = []
//    
//    
//    var complete: (() -> Void)?
//    
//    init() {
//        self.setupDb()
//    }
//    
//    private func setupDb() {
//        let db = Firestore.firestore()
//        self.db = db
//        setupStorage()
//    }
//    
//    private func setupStorage() {
//        let storage = Storage.storage()
//        let storRef = storage.reference()
//        self.storageRef = storRef
//    }
//    
//    func fetchExercises(completion: @escaping([Exercise], [URL], ExerciseInfoStoreError?) -> Void) {
//        DispatchQueue.global(qos: .userInitiated).sync {
//            db.collection("exercises").getDocuments() { (snapshot, error) in
//                if let error = error {
//                    DispatchQueue.main.async {
//                        completion([], [], ExerciseInfoStoreError.CannotFetch(error.localizedDescription))
//                    }
//                    return
//                } else {
//                    for doc in (snapshot?.documents)! {
//                        let exercise = Exercise(dictionary: doc.data())
//                        self.exercises.append(exercise)
//                    }
//                    
//                   // self.fetchVideoReferences(for: exercises) { (videoRefs) in {
//                        
//                 //       }
//                    
//                   // self.fetchExerciseVideosForWorkout(exercises: exercises) { (urls) in
//                        
//                        DispatchQueue.main.async {
//                            //     completion(self.exercises, urls, nil)
//                        }
//                    }
//                }
//            }
//        }
//    }
//    
//    private func fetchVideoReferences(for exercises: [Exercise], completion: @escaping([StorageReference]) -> Void) {
//        var pathReferences: [StorageReference] = []
//        while pathReferences.count < exercises.count {
//            
//            for e in exercises {
//                DispatchQueue.global(qos: .userInitiated).sync {
//                   // self.pathReferences.append(storageRef.child(e.videoURL))
//                    
//                }
//            }
//        }
//        DispatchQueue.main.async {
//            print(pathReferences, "RWRWRW")
//            completion(pathReferences)
//        }
//        
//    }
//    
//   // private func download
//    
////}
