//
//  WorkoutViewController.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

//protocol WorkoutsURLProvider {
//    func fetchVideoReferences(for workout: Workout, completion: @escaping([StorageReference]) -> Void)
//    func downloadURLfromReference(refs: [StorageReference], completion: @escaping(Bool) -> Void)
//}

//class WorkoutViewController: UIViewController {
//    
//    //MARK: - Lifecyle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupNavigationBar()
//        fetchExercises()
//    }
// 
//     func fetchExercises() {
////        if WorkoutDataManager.shared.exercises.isEmpty && !WorkoutDataManager.shared.loadExercises() {
////            //if WorkoutDataManager.shared.exercises.isEmpty {
////            WorkoutDataManager.shared.fetchAllExercises { [weak self] (success) in
////                if success {
////                    self?.workoutGenerated()
////                    print(WorkoutDataManager.shared.exercises.count)
////                    WorkoutDataManager.shared.save()
////                } else {
////                    print("failed")
////                }
////            }
////        } else {
////                workoutGenerated()
////        }
//    }
//    
////    @objc func workoutGenerated() {
////        self.workout = Workout(user: UserManager.shared.user)
////
////    }
//    
//   
//    
//    //MARK: Properties
//    
////    private var workoutManager: WorkoutDataManager {
////        return WorkoutDataManager.shared
////    }
//    
//    //var preworkoutView: PreWorkoutView?
//    var workoutView: WorkoutView?
//   // let loadingView = LoadingView(frame: .zero)
//    
//    var workoutToDisplay: Workout?
////    {
////        didSet {
////        guard let workout = workout else { return }
////            if workoutView == nil {
////            workoutView = WorkoutView(frame: view.frame, rootVC: self, viewModel: WorkoutViewModel(workout: workout))
////            }
////            if references.isEmpty {
//////                fetchVideoReferences(for: workout) { (refs) in
//////                    self.references = refs
//////                }
////            }
//////            if workoutViewModel == nil {
//////                workoutViewModel = WorkoutViewModel(workout: workout)
//////            }
////        }
////    }
//    
//    //refactor
//    private var references: [StorageReference] = [] {
//        didSet {
//           // if self.workoutView.videoView.urls.isEmpty {
////                downloadURLfromReference(refs: references) { (success) in
////                    if success {
////                        print(true, "RWRWR")
////                    } else {
////                        print("error downloading URL from refs")
////                    }
////                }
////            }
//        }
//    }
//
//    
////    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
////        if traitCollection.horizontalSizeClass == .compact {
////            print("protrai mode")
////        } else {
////            // load wide view
////            print("landscape mode")
////        }
////    }
//    
//    //MARK: Private methods
//    
//    private func setupNavigationBar() {
//        navigationItem.title = "Workout"
//    }
//    
////    func setupPreWorkoutUI() {
////       // preworkoutView = PreWorkoutView()
//////        preworkoutView?.preWorkoutViewController = self
////        guard let preworkoutView = preworkoutView else { return }
////        view.addSubview(preworkoutView)
////        
//////        preworkoutView.workoutViewController = self
////        preworkoutView.translatesAutoresizingMaskIntoConstraints = false
////        preworkoutView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
////        preworkoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
////        preworkoutView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
////        preworkoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
////    }
//    
//    func setupLoadingView() {
//        view.addSubview(loadingView)
//        loadingView.translatesAutoresizingMaskIntoConstraints = false
//        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        loadingView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
//        loadingView.heightAnchor.constraint(equalToConstant: view.frame.height /* * 0.6*/).isActive = true
//        //loadingView.runTimer()
//    }
//    
//    func showWorkoutUI() {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(showPreWorkoutUI))
//        if workoutView == nil {
//            workoutView = WorkoutView(frame: self.view.frame, rootVC: self, viewModel: WorkoutViewModel(workout: workout!))
//        }
//        guard let workoutView = workoutView else { return }
//        view.addSubview(workoutView)
//        workoutView.translatesAutoresizingMaskIntoConstraints = false
//        workoutView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        workoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        workoutView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        workoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        
//    }
//    
//    @objc private func showPreWorkoutUI() {
//        fetchExercises()
//        removeAllElementsFromSuperview()
//        workoutView = nil
//        assert(workoutView == nil, "workoutView hasnt been deinit")
//        //setupPreWorkoutUI()
//        navigationItem.rightBarButtonItem = nil
//    }
//    
//    private func removeAllElementsFromSuperview() {
//        view.subviews.forEach({ $0.removeFromSuperview()})
//    }
//}
//
//extension WorkoutViewController: WorkoutsURLProvider {
//    func fetchVideoReferences(for workout: Workout, completion: @escaping([StorageReference]) -> Void) {
//        var pathReferences: [StorageReference] = []
//        while pathReferences.count < workout.exercises.count {
//            
//            for e in workout.exercises {
//                DispatchQueue.global(qos: .userInitiated).sync {
//                    pathReferences.append(WorkoutDataManager.shared.storageRef.child(e.videoURL)/*"videos/" + "\(e.videoURL)")*/)
//                    
//                }
//            }
//        }
//        DispatchQueue.main.async {
//            completion(pathReferences)
//        }
//        
//    }
//    
//    func downloadURLfromReference(refs: [StorageReference], completion: @escaping(Bool) -> Void) {
//        guard let workout = workout else { return }
//        print(workout.exercises.count, "wew")
//        DispatchQueue.global(qos: .userInitiated).async {
//           // while self.workoutView.videoView.urls.count < workout.exercises.count {
//                // refs.forEach { ($0.write(toFile: WorkoutDataManager.shared.localURL) { (url, error) in
//                
//                //}
//                refs.forEach { ($0.downloadURL(completion: { (url, error) in
//                    if let error = error {
//                        //TO DO: - handle error
//                        print(error)
//                        return
//                        
//                    } else if let url = url {
//                       // self.workoutView.videoView.urls.append(url)
//                        
//                    }
//                })
//                    )}
//            }
//      //  }
//    }
//}
