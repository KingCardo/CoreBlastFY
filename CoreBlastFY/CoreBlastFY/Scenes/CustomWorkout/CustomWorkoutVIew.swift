//
//  CustomWorkoutVIew.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 7/20/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class CustomWorkoutView: UIView {
    
    var customWorkoutViewModel: CustomWorkoutViewModel
    weak var customWorkoutViewController: CustomWorkoutViewController?
    
    init(vm: CustomWorkoutViewModel, customWorkoutViewController: CustomWorkoutViewController?) {
        self.customWorkoutViewModel = vm
        self.customWorkoutViewController = customWorkoutViewController
        super.init(frame: .zero)
        bindViewModel()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: CreateWorkoutDelegate?
    
    func bindViewModel() {
        
        setPicker.setSelected = { [unowned self] set in
            self.customWorkoutViewModel.numberOfSets = set
        }
        
        durationPicker.valueSelected = { [unowned self] duration in
            self.customWorkoutViewModel.durationOfExercise = duration
        }
        
        numberOfSecondsRestPicker.valueSelected = { [unowned self] seconds in
            self.customWorkoutViewModel.secondsOfRest = seconds
        }
    }
    
    
    
    private let setPicker = SetPicker()
    private let durationPicker = DurationPicker()
    private let numberOfSecondsRestPicker = NumberOfSecondsRestPicker()
    
    private lazy var durationPickerView: UIPickerView = {
        let dPickerView = UIPickerView()
        dPickerView.backgroundColor = .clear
        dPickerView.delegate = durationPicker
        dPickerView.dataSource = durationPicker
        return dPickerView
    }()
    
    private lazy var numberOfSecondsPickerView: UIPickerView = {
        let dPickerView = UIPickerView()
        dPickerView.backgroundColor = .clear
        dPickerView.delegate = numberOfSecondsRestPicker
        dPickerView.dataSource = numberOfSecondsRestPicker
        return dPickerView
    }()
    
    private lazy var setPickerView: UIPickerView = {
        let sp = UIPickerView()
        sp.backgroundColor = .clear
        sp.dataSource = setPicker
        sp.delegate = setPicker
        return sp
    }()
    
    private let setPickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a number of sets!"
        label.font = UIDevice.isIpad ? UIFont.makeAvenirNext(size: 28) : UIFont.makeTitleFontDB(size: 22)
        label.textColor = .white
        return label
        
    }()
    
    private let setNumberOfRestLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of seconds of rest between exercises!"
        label.font = UIDevice.isIpad ? UIFont.makeAvenirNext(size: 28) : UIFont.makeTitleFontDB(size: 22)
        label.textColor = .white
        return label
        
    }()
    
    private let durationPickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Select duration of each exercise!"
        label.font = UIDevice.isIpad ? UIFont.makeAvenirNext(size: 28) : UIFont.makeTitleFontDB(size: 22)
        label.textColor = .white
        label.backgroundColor = .black
        return label
        
    }()
    
    private lazy var pickerStackView: UIStackView = {
        let psv = UIStackView(arrangedSubviews: [setPickerLabel, setPickerView, durationPickerLabel, durationPickerView, createWorkoutButton, setNumberOfRestLabel, numberOfSecondsPickerView])
        psv.axis = .vertical
        psv.distribution = .fillProportionally
        psv.spacing = 4
        psv.backgroundColor = .black
        return psv
    }()
    
    private lazy var createWorkoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Exercises", for: .normal)
        button.setTitleColor(UIColor.goatBlack, for: .normal)
        button.isUserInteractionEnabled = true
        button.backgroundColor = .goatBlue
        button.titleLabel?.font = UIDevice.isIpad ? UIFont.makeTitleFontDB(size: 30) : UIFont.makeTitleFontDB(size: 20)
        button.addTarget(self, action: #selector(selectExercises(_:)), for: .touchDown)
        button.layer.cornerRadius = UIDevice.isIpad ? 40 : 30
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive =  true
        return button
    }()
    
    @objc func selectExercises(_ sender: UIButton) {
        let numberOfSets = setPicker.selectedSet ?? 2
        let duration = durationPicker.selectedValue ?? 10
        customWorkoutViewModel.numberOfSets = numberOfSets
        customWorkoutViewModel.durationOfExercise = duration
        advanceToExerciseSelection()
    }
    
    private func advanceToExerciseSelection() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            guard let exerciseView = self.customWorkoutViewController?.exerciseSelectionView else { return }
            self.customWorkoutViewController?.view.addSubview(exerciseView)
            exerciseView.translatesAutoresizingMaskIntoConstraints = false
            exerciseView.fillSuperview(padding: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12))
        }
    }
    
    private func promptUser() {
        let ac = AlertController.alert("Oops!", message: "Make sure to select both options!")
        customWorkoutViewController?.present(ac, animated: true, completion: nil)
    }
    
    
    private func setupPickerStackView() {
        addSubview(pickerStackView)
        pickerStackView.translatesAutoresizingMaskIntoConstraints = false
        pickerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        pickerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        pickerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        pickerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
        
    private func setupViews() {
        backgroundColor = .black
        setupPickerStackView()
    }
    
}
