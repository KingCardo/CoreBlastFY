//
//  ExerciseSelectionView.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 7/25/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class ExerciseSelectionView: UIView {
    
    static let cellID = "ExerciseSelectionViewID"
    weak var customViewController: CustomWorkoutViewController?
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Workout".uppercased(), for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .goatBlue
        button.titleLabel?.font = UIDevice.isIpad ? UIFont.makeAvenirNext(size: 38) : UIFont.makeAvenirNext(size: 28)
        button.addTarget(self, action: #selector(selectExercises(_:)), for: .touchDown)
        button.layer.cornerRadius = UIDevice.isIpad ? 30 : 20 //self.frame.height * 0.2
        button.layer.masksToBounds = true
        return button
    }()
    
    @objc func selectExercises(_ sender: UIButton) {
        guard exerciseSelectionViewDataSource.selectedExercises.count > 1 else { promptUser(); return }
        customViewController?.removeView(self)
        customViewController?.createWorkout()
        tableView.reloadData()
    }
    
    private func promptUser() {
        let ac = AlertController.alert("Oops", message: "Select atleast two exercises!")
        customViewController?.present(ac, animated: true, completion: nil)
    }
    
    private lazy var container: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [tableView, doneButton])
        sv.axis = .vertical
        return sv
    }()
    
    private func setupContainer() {
        addSubview(container)
        container.fillSuperview()
    }
    
    let exerciseSelectionViewDataSource = ExerciseSelectionDataSourceDelegate()
    
    private func setUpTableView() {
        tableView.dataSource = exerciseSelectionViewDataSource
        tableView.delegate = exerciseSelectionViewDataSource
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ExerciseSelectionView.cellID)
    }
    
    
    init(customViewController: CustomWorkoutViewController) {
        self.customViewController = customViewController
        super.init(frame: .zero)
        backgroundColor = .black
        setupContainer()
        setUpTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
