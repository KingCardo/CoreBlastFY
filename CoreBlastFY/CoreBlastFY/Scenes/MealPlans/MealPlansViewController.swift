//
//  MealPlansViewController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/16/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MealPlansDisplayLogic: class {
    func displayPlans(viewModel: MealPlans.GetPlan.ViewModel)
}

class MealPlansViewController: UICollectionViewController, MealPlansDisplayLogic {
    var interactor: (MealPlansBusinessLogic & MealPlansDataStore)?
    var router: (NSObjectProtocol & MealPlansRoutingLogic & MealPlansDataPassing)?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: Object lifecycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(MealPlansOverviewCollectionViewCell.self, forCellWithReuseIdentifier: MealPlansOverviewCollectionViewCell.id)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = MealPlansInteractor()
        let presenter = MealPlansPresenter()
        let router = MealPlansRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    func routeToMealPlanDetails() {
        router?.routeToMealPlanDetailController()
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(purchaseSuccess), name: PurchaseSuccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(purchaseCancelled), name: PurchaseCancelled, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPlans()
    }
    
    // MARK: Do something
    
    @objc private func purchaseSuccess() {
        removeLoadingSpinner()
        routeToMealPlanDetails()
    }
    
    @objc private func purchaseCancelled() {
        removeLoadingSpinner()
    }
    
    private var loadingSpinner: UIActivityIndicatorView?
    
    private func displayLoadingSpinner() {
        loadingSpinner = UIActivityIndicatorView(style: .large)
        loadingSpinner?.color = .white
        loadingSpinner?.startAnimating()
        DispatchQueue.main.async { [weak self] in
        guard let self = self else { return }
            self.view.addSubview(self.loadingSpinner!)
        
            self.loadingSpinner?.translatesAutoresizingMaskIntoConstraints = false
            self.loadingSpinner?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.loadingSpinner?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
        
    }
    
    private func removeLoadingSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loadingSpinner?.stopAnimating()
            self.loadingSpinner?.removeFromSuperview()
            self.loadingSpinner = nil
            self.view.setNeedsDisplay()
        }
    }
   
    
    var displayedPlans: [MealPlans.GetPlan.ViewModel.PlanOverview] = []
    
    private func getPlans() {
        let request = MealPlans.GetPlan.Request()
        interactor?.getPlansOverview(request: request)
    }
    
    func displayPlans(viewModel: MealPlans.GetPlan.ViewModel) {
        displayedPlans = viewModel.planOverViews
        collectionView.reloadData()
    }
}

extension MealPlansViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIDevice.isIpad ?  .init(width: view.frame.width - 64, height: 500) : .init(width: view.frame.width - 32, height: MealPlansViewController.Dimensions.mealPlanCellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}

extension MealPlansViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedPlans.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MealPlansOverviewCollectionViewCell.id, for: indexPath) as? MealPlansOverviewCollectionViewCell else {
            return UICollectionViewCell() }
        let plan = displayedPlans[indexPath.item]
        cell.configure(item: plan)
        return cell
        
    }
}

extension MealPlansViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let plans = InAppIds.all[indexPath.item]
        StoreObserver.shared.productId = plans
        
        routeToMealPlanDetails()
        
    }
}

extension MealPlansViewController {
    struct Dimensions {
        static let cellSize: CGFloat = 100
        static let mealPlanCellSize: CGFloat = 300
    }
}
