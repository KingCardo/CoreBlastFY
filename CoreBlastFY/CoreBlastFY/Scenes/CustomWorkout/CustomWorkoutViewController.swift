//
//  CustomWorkoutViewController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 7/20/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

protocol CreateWorkoutDelegate: AnyObject {
    func createWorkout(duration: Int, numberOfSets: Int)
}

class CustomWorkoutViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(workoutComplete), name: workoutCompleteNotification2, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    // MARK: - Views
    
    private let customWorkoutVM = CustomWorkoutViewModel()
    
    lazy var exerciseSelectionView = ExerciseSelectionView(customViewController: self)
    
    private lazy var mainView = CustomWorkoutView(vm: customWorkoutVM, customWorkoutViewController: self)
    private var workoutViewController: WorkoutViewController?
    
    private var loadingView: LoadingView?
    private var loadingSpinner: UIActivityIndicatorView?
    
    // MARK: - Methods
    
    @objc func workoutComplete() {
        workoutViewController = nil
        //self = nil
        view.setNeedsDisplay()
    }
    
    private func setBackgroundColor() {
        view.backgroundColor = .black
    }
    
    private func setupMainView() {
        view.addSubview(mainView)
        mainView.fillSuperview()
    }
    
    private func setupViews() {
        setBackgroundColor()
        setupMainView()
        navigationItem.title = "Custom Workout!"
    }
    
    func removeView(_ view: UIView) {
        view.removeFromSuperview()
    }
    
    func createWorkout() {
        let exercises = exerciseSelectionView.exerciseSelectionViewDataSource.selectedExercises
        customWorkoutVM.addExercises(exercises: exercises)
        workoutViewController = WorkoutViewController()
        workoutViewController!.interactor?.workout = customWorkoutVM.workout
        displayLoadingView()
        
    }
    
    private func presentWorkoutVC() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let self = self else { return }
            guard self.workoutViewController != nil else { return }
            self.show(self.workoutViewController!, sender: nil)
            self.customWorkoutVM.workout = nil
            self.exerciseSelectionView.exerciseSelectionViewDataSource.resetSelectedExercises()
            self.customWorkoutVM.reset()
        }
    }
    
    private func removeLoadingView() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
    private func displayLoadingView() {
        loadingView = LoadingView(frame: .zero, backgroundColor: .black)
        view.addSubview(loadingView!)
        self.tabBarController?.tabBar.isHidden = true
        loadingView!.translatesAutoresizingMaskIntoConstraints = false
        loadingView!.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView!.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView!.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView!.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView!.runTimer { [weak self] in
            self?.removeLoadingView()
            self?.presentWorkoutVC()
        }
    }
}
