//
//  ExerciseSelectionDataSourceDelegate.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 7/25/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class ExerciseSelectionDataSourceDelegate: NSObject, UITableViewDataSource {
    
    private let exercises: [Exercise] = LocalExercises.exercises
    
    private(set) var selectedExercises: [Exercise] = [] {
        didSet  {
            if selectedExercises.count >= 2 {
                hasEnoughExercisesSelected?(true)
            } else {
                hasEnoughExercisesSelected?(false)
            }
        }
    }
    
    var hasEnoughExercisesSelected: ((Bool) ->  Void)?
    
    func resetSelectedExercises() {
        selectedExercises = []
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseSelectionView.cellID, for: indexPath)
        cell.textLabel?.text = exercises[indexPath.row].name.capitalized
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.tintColor = UIColor.goatBlue
        cell.textLabel?.font = UIDevice.isIpad ? UIFont.makeAvenirNext(size: 28) : UIFont.makeAvenirNext(size: 16)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.goatBlack
        cell.selectedBackgroundView = backgroundView
        return cell
    }
}

extension ExerciseSelectionDataSourceDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let exercise = exercises[indexPath.row]
        if !selectedExercises.contains(exercise) {
            selectedExercises.append(exercise)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .checkmark
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let exercise = exercises[indexPath.row]
        if selectedExercises.contains(exercise) {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.accessoryType = .none
            }
            selectedExercises.removeAll { (sexercise) -> Bool in
                sexercise == exercise
            }
        }
    }
}
