//
//  WorkoutView.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/2/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class MealPlanView: UIView {
    
    var item: MealPlanDetail.FetchDetails.ViewModel.DisplayMealPlanDetails? {
        didSet {
            compactItems = (item?.recipe.compactMap { $0 })!
            tips = item?.tips.compactMap { $0 } ?? []
        }
    }
    
    var tips: [String] = []
    
    var compactItems: [Recipe] = []
    weak var parent: MealPlanCell?
   
    private lazy var workoutCollectionView: UICollectionView = {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.autoresizingMask = [.flexibleHeight]
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        cv.isScrollEnabled = true
        cv.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.id)
        cv.register(TipsCollectionViewCell.self, forCellWithReuseIdentifier: TipsCollectionViewCell.id)
        return cv
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(workoutCollectionView)
        workoutCollectionView.translatesAutoresizingMaskIntoConstraints = false
        workoutCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        workoutCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
        workoutCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        workoutCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}

extension MealPlanView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item?.isTips ?? false ? tips.count : compactItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if item?.isTips ?? false {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipsCollectionViewCell.id, for: indexPath) as! TipsCollectionViewCell
            let tip = tips[indexPath.row]
                cell.configure(with: tip)
            return cell
            
        } else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.id, for: indexPath) as! RecipeCell
         let recipe = compactItems[indexPath.row]
            cell.configure(with: recipe)
        return cell
        }
    }
    
    private func displayMealDetails(with recipe: Recipe?) {
        parent?.routeToMealDetails(with: recipe)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        if item?.isTips ?? false {
            print("Tips Selected")
        } else {
        displayMealDetails(with: compactItems[indexPath.item])
        }

//       // if isPurchase() {
//        guard let workout = program?.sortedWorkouts[indexPath.row] else { return }
//        //TO DO: - Make more efficient
//        if program?.workouts[indexPath.row].videoURL == nil {
//
//            ProgramController.shared.downloadAssetUrl(ref: ProgramController.shared.storageRef.child("videos/\(workout.videoString)")) { [weak self] (url) in
//                if url != nil {
//                    self?.program?.workouts[indexPath.row].videoURL = url
//                    if let vc = self?.findViewController() {
//                        let videoURL = url!
//                         self?.presentAVPlayer(vc: vc, url: videoURL)
//                    }
//                }
//            }
//        } else {
//            // you have the url dont have to download
//            if let vc = self.findViewController() {
//                if let videoURL = program?.workouts[indexPath.row].videoURL!  {
//                presentAVPlayer(vc: vc, url: videoURL)
//                }
//            }
//     //       }
////        } else {
////            buyCoreBlast()
//        }
}
//       private func presentAVPlayer(vc: UIViewController, url: URL) {
//            let player = AVPlayer(url: url)
//            let playerViewController = AVPlayerViewController()
//            playerViewController.player = player
//            vc.present(playerViewController, animated: true) {
//                playerViewController.player!.play()
//            }
//        }
   // }
    
   
}

extension MealPlanView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width - 64, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 16, bottom: 0, right: 16)
    }
}

