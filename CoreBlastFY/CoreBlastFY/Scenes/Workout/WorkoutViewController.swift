//
//  WorkoutViewController.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//

import UIKit

protocol WorkoutDisplayLogic: AnyObject {
    func displayWorkout(viewModel: WorkoutInfo.FetchWorkout.ViewModel)
}

class WorkoutViewController: UIViewController, WorkoutDisplayLogic {
    var interactor: (WorkoutBusinessLogic & WorkoutDataStore)?
    var router: (NSObjectProtocol & WorkoutRoutingLogic & WorkoutDataPassing)?
    var workoutView: WorkoutView?
    var viewModel: WorkoutInfo.FetchWorkout.ViewModel?
    var tapGesture: UITapGestureRecognizer?
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        viewModel = nil
        workoutView = nil
        interactor = nil
        print(workoutView == nil)
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = WorkoutInteractor()
        let presenter = WorkoutPresenter()
        let router = WorkoutRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        view.setNeedsDisplay()
        view.setNeedsLayout()
    }
    
    private func setupNavigationBar() {
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .black
    }
    
    // MARK: Routing
    
    private func routeToPreWorkoutScene() {
        router?.routeToPreWorkoutScene()
    }
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        fetchCustomWorkout()
        registerObservers()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleStateOfWorkout))
        view.addGestureRecognizer(tapGesture!)
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.isHidden = true
            self?.view.setNeedsDisplay()
            self?.view.setNeedsLayout()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func fetchCustomWorkout() {
        if let workout = interactor?.workout, workout.isCustom {
            interactor?.createCustomWorkout(workout: workout)
        } else {
            fetchWorkout()
        }
    }
    
    
    @objc private func preventScreenRecording() {
        let isRecording = UIScreen.main.isCaptured
        
        if isRecording {
            workoutView?.isHidden = true
            workoutView?.pauseWorkout()
        } else {
            workoutView?.isHidden = false
            workoutView?.resumeWorkout()
        }
    }
    
    
    private func registerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(workoutComplete), name: workoutCompleteNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pauseWorkoutFromInterruption), name: PauseWorkoutNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(preventScreenRecording), name: UIScreen.capturedDidChangeNotification, object: nil)
    }
    
    @objc private func pauseWorkoutFromInterruption() {
        workoutView?.pauseWorkout()
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.isHidden = false
            self?.view.setNeedsDisplay()
            self?.view.setNeedsLayout()
        }
    }
    
    @objc private func pauseWorkout() {
        guard let tapGesture = tapGesture else { return }
        handleStateOfWorkout(tapGesture)
    }
    
    @objc private func handleStateOfWorkout(_ gesture: UITapGestureRecognizer) {
        switch gesture.state {
        case .ended :
            guard workoutView != nil && workoutView?.loadingView == nil else { return }
            if workoutView!.timerIsRunning {
                workoutView?.pauseWorkout()
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.navigationBar.isHidden = false
                    self?.view.setNeedsDisplay()
                    self?.view.setNeedsLayout()
                }
            } else {
                workoutView?.resumeWorkout()
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.navigationBar.isHidden = true
                    self?.view.setNeedsDisplay()
                    self?.view.setNeedsLayout()
                }
            }
        default: break
        }
    }
    
    @objc private func workoutComplete() {
        workoutView = nil
        showPreWorkoutUI()
        NotificationCenter.default.post(name: workoutCompleteNotification2, object: nil)
    }
    
    
    // MARK: Do something
    
    func fetchWorkout() {
        guard let exercises = interactor?.exercises else { return }
        let request = WorkoutInfo.FetchWorkout.Request(exercises: exercises)
        interactor?.fetchWorkout(request: request)
    }
    
    func displayWorkout(viewModel: WorkoutInfo.FetchWorkout.ViewModel) {
        showWorkoutUI(with: viewModel)
    }
    
    private func showWorkoutUI(with viewModel: WorkoutInfo.FetchWorkout.ViewModel) {
        if workoutView == nil {
            workoutView = WorkoutView(frame: view.frame, rootVC: self, viewModel: viewModel,  secondsOfRest: interactor?.workout?.secondsOfRest ?? 10)
        }
        guard let workoutView = workoutView else { return }
        view.addSubview(workoutView)
        workoutView.translatesAutoresizingMaskIntoConstraints = false
        workoutView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        workoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        workoutView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        workoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    @objc private func showPreWorkoutUI() {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
