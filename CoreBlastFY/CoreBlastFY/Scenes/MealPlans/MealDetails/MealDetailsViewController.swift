//
//  MealDetailsViewController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/25/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MealDetailsDisplayLogic: class {
    func displayRecipe(viewModel: MealDetails.RecipeDetails.ViewModel.RecipeDetails)
}

class MealDetailsViewController: UIViewController, MealDetailsDisplayLogic {
    var interactor: (MealDetailsBusinessLogic & MealDetailsDataStore)?
    var router: (NSObjectProtocol & MealDetailsRoutingLogic & MealDetailsDataPassing)?
    var displayedRecipe: MealDetails.RecipeDetails.ViewModel.RecipeDetails?
    enum Items {
        case image
        case title
        case options
        case details
    }
    
    let items: [Items] = [.image, .title, .options, .details]
    
    enum Mode {
        case ingredients
        case instructions
    }
    
    var mode: Mode = .ingredients
    
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
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = MealDetailsInteractor()
        let presenter = MealDetailsPresenter()
        let router = MealDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
        configure()
    }
    
    // MARK: Do something
    
    private lazy var recipeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.autoresizingMask = [.flexibleHeight]
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        cv.isScrollEnabled = true
        cv.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCollectionViewCell.id)
        cv.register(InstructionsCollectionViewCell.self, forCellWithReuseIdentifier: InstructionsCollectionViewCell.id)
        cv.register(HeaderCollectionImageView.self, forCellWithReuseIdentifier: HeaderCollectionImageView.id)
        cv.register(RecipeDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: RecipeDescriptionCollectionViewCell.id)
        cv.register(RecipeOptionsCollectionViewCell.self, forCellWithReuseIdentifier: RecipeOptionsCollectionViewCell.id)
        return cv
        
    }()
    
    private func configure() {
        interactor?.passPresenterRecipe(with: interactor?.recipe)
    }
    
    func displayRecipe(viewModel: MealDetails.RecipeDetails.ViewModel.RecipeDetails) {
        displayedRecipe = viewModel
        recipeCollectionView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(recipeCollectionView)
        recipeCollectionView.fillSuperview()
    }
}

extension MealDetailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0...2: return 1
        case 3:
            switch mode {
            case .ingredients:
                return displayedRecipe?.ingredients.count ?? 0
            case .instructions:
                return displayedRecipe?.instructions.count ?? 0
            }
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionImageView.id, for: indexPath) as! HeaderCollectionImageView
            cell.configure(with: displayedRecipe)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeDescriptionCollectionViewCell.id, for: indexPath) as! RecipeDescriptionCollectionViewCell
            cell.configure(with: displayedRecipe)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeOptionsCollectionViewCell.id, for: indexPath) as! RecipeOptionsCollectionViewCell
            cell.option1Buttonhandler = { [weak self] in
                self?.mode = .ingredients
                self?.recipeCollectionView.reloadData()
            }
            cell.option2Buttonhandler = {  [weak self] in
                self?.mode = .instructions
                self?.recipeCollectionView.reloadData()
            }
            return cell
        default:
            switch mode {
            case .ingredients:
                let ingredient = displayedRecipe?.ingredients[indexPath.item]
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCollectionViewCell.id, for: indexPath) as? IngredientsCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(with: ingredient)
                return cell
                
            case .instructions:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstructionsCollectionViewCell.id, for: indexPath) as? InstructionsCollectionViewCell else { return UICollectionViewCell() }
                let instruction = displayedRecipe?.instructions[indexPath.item]
                cell.configure(with: instruction)
                return cell
            }
        }
    }
}

extension MealDetailsViewController: UICollectionViewDelegate {
    
}

extension MealDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0: return .init(width: collectionView.frame.width, height: 300)
        case 1: return .init(width: collectionView.frame.width, height: 100)
        case 2: return .init(width: collectionView.frame.width, height: 50)
        case 3: return .init(width: collectionView.frame.width, height: 45)
        default: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 0, bottom: 0, right: 0)
    }
}
