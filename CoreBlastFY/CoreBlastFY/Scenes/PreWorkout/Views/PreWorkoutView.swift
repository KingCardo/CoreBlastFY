//
//  PreWorkoutView.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/13/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class PreWorkoutView: UIView {
    
    var preWorkoutViewModel: PreWorkout.FetchUser.ViewModel
    weak var preWorkoutViewController: PreWorkoutViewController?
    let coreLevelCountLabel = UILabel()
    let totalPointsLevel = UILabel()
    let nextLevelCountLabel = UILabel()
    let nextWorkoutDateLabel = UILabel()
    let welcomeLabel = UILabel()
    let startWorkoutButton = UIButton(frame: CGRect(origin: .zero, size: Style.Dimension.startWorkoutButtonSize))
    
    @objc private func startWorkout() {
        self.preWorkoutViewController?.displayLoadingView()
    }

  
    init(frame: CGRect = .zero, viewModel: PreWorkout.FetchUser.ViewModel) {
        self.preWorkoutViewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white

          let coreLevelLabel = UILabel()
          coreLevelLabel.text = "Core Level"
          coreLevelLabel.font = UIFont.makeAvenirNext(size: Style.titleFontSize)
        
          coreLevelCountLabel.text = preWorkoutViewModel.userDetails.coreLevel
          coreLevelCountLabel.font = UIFont.systemFont(ofSize: Style.dataFontSize, weight: .semibold)
          
          let coreLevelStackView = UIStackView(arrangedSubviews: [coreLevelLabel, coreLevelCountLabel])
          coreLevelStackView.alignment = .center
          coreLevelStackView.distribution = .fillEqually
          coreLevelStackView.axis = .vertical
          coreLevelStackView.spacing = Style.stackViewSpacing
          
          let totalPointsLabel = UILabel()
          totalPointsLabel.text = "Total Points"
          totalPointsLabel.font = UIFont.makeAvenirNext(size: Style.titleFontSize)
        
          totalPointsLevel.text = preWorkoutViewModel.userDetails.totalPoints
          totalPointsLevel.font = UIFont.systemFont(ofSize: Style.dataFontSize, weight: .semibold)
          
          let totalPointsStackView = UIStackView(arrangedSubviews: [totalPointsLabel, totalPointsLevel])
          totalPointsStackView.alignment = .center
          totalPointsStackView.distribution = .fillEqually
          totalPointsStackView.axis = .vertical
          totalPointsStackView.spacing = Style.stackViewSpacing
          
          let nextLevelLabel = UILabel()
          nextLevelLabel.text = "Next Level"
          nextLevelLabel.font = UIFont.makeAvenirNext(size: Style.titleFontSize)
        
          nextLevelCountLabel.text = preWorkoutViewModel.userDetails.nextLevel
          nextLevelCountLabel.font = UIFont.systemFont(ofSize: Style.dataFontSize, weight: .semibold)
          
          let nextLevelStackView = UIStackView(arrangedSubviews: [nextLevelLabel, nextLevelCountLabel])
          nextLevelStackView.alignment = .center
          nextLevelStackView.distribution = .fillEqually
          nextLevelStackView.axis = .vertical
          nextLevelStackView.spacing = Style.stackViewSpacing
          
          let levelStackView = UIStackView(arrangedSubviews: [coreLevelStackView, totalPointsStackView, nextLevelStackView])
          levelStackView.alignment = .center
          levelStackView.distribution = .fillEqually
          levelStackView.axis = .horizontal
          
          addSubview(levelStackView)
          levelStackView.translatesAutoresizingMaskIntoConstraints = false
          levelStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Style.Dimension.edgeInsets.left).isActive = true
          levelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Dimension.edgeInsets.top).isActive = true
          levelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Style.Dimension.edgeInsets.top).isActive = true
          
          let name = viewModel.userDetails.name
        welcomeLabel.font = UIFont.makeAvenirNext(size: 20)
        welcomeLabel.numberOfLines = 0
        if name == nil {
            welcomeLabel.text = ""
        } else {
            welcomeLabel.text = "Welcome \(String(describing: name!))!\nTime to put in work!"
        }
        
          startWorkoutButton.setTitle("Start Workout", for: .normal)
          startWorkoutButton.setTitleColor(.white, for: .normal)
          startWorkoutButton.titleLabel?.font = UIFont.makeAvenirNext(size: 35)
          startWorkoutButton.addTarget(self, action: #selector(startWorkout), for: .touchDown)
          startWorkoutButton.backgroundColor = .goatBlue
          startWorkoutButton.layer.shadowColor = UIColor.white.cgColor
          startWorkoutButton.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
          startWorkoutButton.layer.shadowRadius = 5.0
          startWorkoutButton.layer.shadowOpacity = 0.5
          startWorkoutButton.layer.cornerRadius = 45//startWorkoutButton.frame.width / 2
          startWorkoutButton.clipsToBounds = true
          
          
          addSubview(startWorkoutButton)
          startWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
          startWorkoutButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
          startWorkoutButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
          startWorkoutButton.heightAnchor.constraint(equalToConstant: Style.Dimension.startWorkoutButtonSize.height).isActive = true
          //startWorkoutButton.widthAnchor.constraint(equalToConstant: Style.Dimension.startWorkoutButtonSize.width).isActive = true
          startWorkoutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Dimension.edgeInsets.right).isActive = true
          startWorkoutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Style.Dimension.edgeInsets.right).isActive = true
        
        addSubview(welcomeLabel)
               welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.bottomAnchor.constraint(equalTo: startWorkoutButton.topAnchor, constant: -32).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: startWorkoutButton.leadingAnchor).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
          
          let nextWorkoutLabel = UILabel()
          nextWorkoutLabel.text = "Next Workout"
          nextWorkoutLabel.font = UIFont.makeAvenirNext(size: Style.titleFontSize)
          
          nextWorkoutDateLabel.text = preWorkoutViewModel.userDetails.nextWorkoutDate
          nextWorkoutDateLabel.font = UIFont.systemFont(ofSize: Style.dataFontSize, weight: .semibold)
          
          let nextWorkoutStackView = UIStackView(arrangedSubviews: [nextWorkoutLabel, nextWorkoutDateLabel])
          nextWorkoutStackView.alignment = .center
          nextWorkoutStackView.distribution = .fillEqually
          nextWorkoutStackView.axis = .vertical
          nextWorkoutStackView.spacing = Style.stackViewSpacing
          
          addSubview(nextWorkoutStackView)
          nextWorkoutStackView.translatesAutoresizingMaskIntoConstraints = false
          nextWorkoutStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Style.Dimension.edgeInsets.left).isActive = true
          nextWorkoutStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
        
//        if let _ = self.workoutViewController?.workout {
//            //we have workout already
//        } else {
//            self.workoutViewController?.fetchExercises()
//
//        }
//        // Find better animation
//        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveLinear, animations: { [weak self] in
//            self?.removeFromSuperview()
//            }, completion: { (success) in
//                if success {
//                    self.workoutViewController?.showWorkoutUI()
//                    self.workoutViewController?.showLoadingView()
//                    self.workoutViewController?.workoutView?.isHidden = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//
//                        self.workoutViewController?.loadingView.removeFromSuperview()
//
//                        self.workoutViewController?.workoutView?.isHidden = false
//                        self.workoutViewController?.workoutView?.videoView.playVideo()
//                        self.workoutViewController?.workoutView?.runTimer()
//                        //self.workoutViewController?.workoutView.addDisplayLink()
//                    }
//                }
//        })
//    }

}

extension PreWorkoutView {
    enum Style {
        static let titleFontSize: CGFloat = 18
        static let dataFontSize: CGFloat = 22
        static let stackViewSpacing: CGFloat = 4
        
        enum Dimension {
              static let startWorkoutButtonSize = CGSize(width: 300, height: 90)
              static let edgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 24, right: 16)
           }
    }
}
