//
//  WorkoutViewController.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/26/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WorkoutDisplayLogic: class {
    func displayWorkout(viewModel: WorkoutInfo.FetchWorkout.ViewModel)
}

class WorkoutViewController: UIViewController, WorkoutDisplayLogic {
    var interactor: (WorkoutBusinessLogic & WorkoutDataStore)?
    var router: (NSObjectProtocol & WorkoutRoutingLogic & WorkoutDataPassing)?
    var workoutView: WorkoutView?
    var viewModel: WorkoutInfo.FetchWorkout.ViewModel?
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        workoutView?.workoutFinished()
        workoutView = nil
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
        self.tabBarController?.tabBar.isHidden = true
        fetchWorkout()
        NotificationCenter.default.addObserver(self, selector: #selector(workoutComplete), name: workoutCompleteNotification, object: nil)
        
    }
    
    @objc private func workoutComplete() {
        showPreWorkoutUI()
        workoutView = nil
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
        
        //change to pause
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(showPreWorkoutUI))
        if workoutView == nil {
            workoutView = WorkoutView(frame: self.view.frame, rootVC: self, viewModel: viewModel)
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
        //self.navigationController?.navigationItem.leftBarButtonItem = nil
        
    }
    
}
