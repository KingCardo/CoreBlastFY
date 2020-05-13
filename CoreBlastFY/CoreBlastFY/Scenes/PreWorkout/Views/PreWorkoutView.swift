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
    
    let totalPointsLevel = UILabel()
    let nextLevelCountLabel = UILabel()
    let nextWorkoutDateLabel = UILabel()
    let welcomeLabel = UILabel()
    let startWorkoutButton = PulsingView()
    
    init(frame: CGRect = .zero, viewModel: PreWorkout.FetchUser.ViewModel) {
        self.preWorkoutViewModel = viewModel
        super.init(frame: frame)
        startWorkoutButton.preWorkoutView = self
        
        backgroundColor = .black
        
        let totalPointsLabel = UILabel()
        totalPointsLabel.text = "Total Points"
        totalPointsLabel.font = self.traitCollection.verticalSizeClass == .regular ? UIFont.makeAvenirNext(size: Style.titleFontSize) : UIFont.makeFontSet(size: Style.titleFontSize)
        totalPointsLabel.textColor = .white
        
        totalPointsLevel.text = preWorkoutViewModel.userDetails.totalPoints
        totalPointsLevel.font = self.traitCollection.verticalSizeClass == .regular ? UIFont.makeAvenirNext(size: Style.dataFontSize) : UIFont.makeFontSet(size: Style.dataFontSize)
        totalPointsLevel.textColor = .white
        
        
        let totalPointsStackView = UIStackView(arrangedSubviews: [totalPointsLabel, totalPointsLevel])
        totalPointsStackView.alignment = .center
        totalPointsStackView.distribution = .fillEqually
        totalPointsStackView.axis = .vertical
        totalPointsStackView.spacing = Style.stackViewSpacing
        
        let nextLevelLabel = UILabel()
        nextLevelLabel.text = "Next Level"
        nextLevelLabel.font =  self.traitCollection.verticalSizeClass == .regular ? UIFont.makeAvenirNext(size: Style.titleFontSize) : UIFont.makeFontSet(size: Style.titleFontSize)
        nextLevelLabel.textColor = .white
        
        nextLevelCountLabel.text = preWorkoutViewModel.userDetails.nextLevel
        nextLevelCountLabel.font = self.traitCollection.verticalSizeClass == .regular ? UIFont.makeAvenirNext(size: Style.dataFontSize) : UIFont.makeFontSet(size: Style.dataFontSize)
        nextLevelCountLabel.textColor = .white
        
        let nextLevelStackView = UIStackView(arrangedSubviews: [nextLevelLabel, nextLevelCountLabel])
        nextLevelStackView.alignment = .center
        nextLevelStackView.distribution = .fillEqually
        nextLevelStackView.axis = .vertical
        nextLevelStackView.spacing = Style.stackViewSpacing
        
        let levelStackView = UIStackView(arrangedSubviews: [ totalPointsStackView, nextLevelStackView])
        levelStackView.alignment = .center
        levelStackView.distribution = .fillEqually
        levelStackView.axis = .horizontal
        
        addSubview(levelStackView)
        levelStackView.translatesAutoresizingMaskIntoConstraints = false
        levelStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Style.Dimension.edgeInsets.left).isActive = true
        levelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Dimension.edgeInsets.top).isActive = true
        levelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Style.Dimension.edgeInsets.top).isActive = true
        
        let name = viewModel.userDetails.name
        welcomeLabel.font = self.traitCollection.verticalSizeClass == .regular ? UIFont.makeAvenirNext(size: 20) : UIFont.makeFontSet(size: 20)
        welcomeLabel.numberOfLines = 0
        if name == nil {
            welcomeLabel.text = ""
        } else {
            welcomeLabel.text = "Welcome \(String(describing: name!))!\nTime to put in work!"
        }
        
        
        addSubview(startWorkoutButton)
        startWorkoutButton.translatesAutoresizingMaskIntoConstraints = false
        startWorkoutButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        startWorkoutButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        let nextWorkoutLabel = UILabel()
        nextWorkoutLabel.text = "Next Workout"
        nextWorkoutLabel.font = self.traitCollection.verticalSizeClass == .regular ? UIFont.makeAvenirNext(size: Style.dataFontSize) : UIFont.makeFontSet(size: Style.dataFontSize)
        nextWorkoutLabel.textColor = .white
        
        nextWorkoutDateLabel.text = preWorkoutViewModel.userDetails.nextWorkoutDate
        nextWorkoutDateLabel.font = self.traitCollection.verticalSizeClass == .regular ? UIFont.makeAvenirNext(size: Style.dataFontSize) : UIFont.makeFontSet(size: Style.dataFontSize)//UIFont.preferredFont(forTextStyle: .body).withSize(Style.dataFontSize)
        nextWorkoutDateLabel.textColor = .white
        
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
    
}

extension PreWorkoutView {
    enum Style {
        static let titleFontSize: CGFloat = 18
        static let dataFontSize: CGFloat = 22
        static let stackViewSpacing: CGFloat = 4
        
        enum Dimension {
            static let startWorkoutButtonSize = CGSize(width: 260, height: 260)//90)
            static let edgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 24, right: 16)
        }
    }
}
