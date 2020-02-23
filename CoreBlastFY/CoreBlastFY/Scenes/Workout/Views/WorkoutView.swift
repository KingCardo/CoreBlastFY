//
//  WorkoutView.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/13/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class WorkoutView: UIView {

    private var setNumber = 1
    private var iteration = 0
    private var workoutDuration: TimeInterval
    
    private var frameOfVideoView: CGRect {
        let height = self.frame.height * 0.6
        return CGRect(x: 0, y: 0, width: self.frame.width, height: height)
    }
    
    weak var rootViewController: WorkoutViewController?
    private var workoutViewModel: WorkoutInfo.FetchWorkout.ViewModel
    
    private let setCountLabel = UILabel()
    private let tipsLabel = UILabel()
    private let durationLeftLabel = UILabel()
    private let exerciseNameLabel = UILabel()
    private var workoutTimer = Timer()
    private var exerciseTimer = Timer()
    private var restTimer = Timer()
    private var timerIsRunning = false
    
    private func runExerciseTimer() {
        exerciseTimer = Timer.scheduledTimer(timeInterval: exerciseDuration, target: self, selector: #selector(fireExerciseTimer), userInfo: nil, repeats: true)
    }
    
    private func runRestTimer() {
        restTimer = Timer.scheduledTimer(timeInterval: setDuration, target: self, selector: #selector(fireRestTimer), userInfo: nil, repeats: true)
    }
    
    var videoView: VideoView
    private var exercises: [Exercise]
   
    private var setDuration: TimeInterval
    private var exerciseDuration: TimeInterval
    private var restDuration: TimeInterval
    private var numberOfSets: Int {
        guard let number = Int(workoutViewModel.workoutDetails.numberOfSets) else { return 4 }
        return number
    }
    
    @objc func fireRestTimer() {
        if setNumber <= numberOfSets {
            setNumber += 1
            setCountLabel.text = "Set \(setNumber) of \(workoutViewModel.workoutDetails.numberOfSets)"
            UIView.animate(withDuration: 1.0) { [weak self] in
                self?.setCountLabel.transform = CGAffineTransform(scaleX: 5, y: 5)
                self?.setCountLabel.transform = .identity
            }
        }
    }
    
    @objc private func fireExerciseTimer() {
        if iteration < exercises.count - 1 {
            iteration += 1
        } else {
            iteration = 0
        }
        updateExerciseViews()

    }
   
    private func updateExerciseViews() {
        tipsLabel.text = workoutViewModel.workoutDetails.exercises[iteration].tip.capitalized
        exerciseNameLabel.text = workoutViewModel.workoutDetails.exercises[iteration].name.capitalized
        videoView.player?.player?.advanceToNextItem()
    }
    
    func runTimer() {
        runExerciseTimer()
        runRestTimer()
        workoutTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timerIsRunning = true
    }
    
    @objc private func fireTimer() {
        if workoutDuration > 0 {
            workoutDuration -= 1//0.01
            durationLeftLabel.text = timeString(time: workoutDuration)
        } else {
            UserManager.incrementPoint()
            UserManager.calculateLevel(totalPoints: UserAPI.user.totalPoints)
            timerIsRunning = false
            workoutTimer.invalidate()
            exerciseTimer.invalidate()
            restTimer.invalidate()
            workoutComplete?()

        }
    }
    
    var workoutComplete: (() -> Void)?
    
    init(frame: CGRect, rootVC: UIViewController, viewModel: WorkoutInfo.FetchWorkout.ViewModel) {
        rootViewController = rootVC as? WorkoutViewController
        workoutViewModel = viewModel
        workoutDuration = workoutViewModel.workoutDetails.workoutDurationDouble
        exercises = workoutViewModel.workoutDetails.exercises
        exerciseDuration = workoutViewModel.workoutDetails.secondsOfExercise
        restDuration = workoutViewModel.workoutDetails.secondsOfRest
        setDuration = workoutViewModel.workoutDetails.setDuration
        let videoUrls: [URL] = workoutViewModel.workoutDetails.exercises.compactMap {  $0.video }
        let array = Array(repeating: videoUrls, count: Int(workoutViewModel.workoutDetails.numberOfSets)!).flatMap({$0})
        videoView = VideoView(frame: frame, urls: array, loopCount: -1)
        
        super.init(frame: frame)
        backgroundColor = .black
        
        setCountLabel.font = UIFont.makeAvenirNext(size: Style.titleFontSize)
        setCountLabel.textColor = .white
        
        setCountLabel.text = "Set \(setNumber) of \(workoutViewModel.workoutDetails.numberOfSets)"
        tipsLabel.text = workoutViewModel.workoutDetails.exercises[iteration].tip.capitalized
        tipsLabel.numberOfLines = 0
        tipsLabel.font = UIFont.makeAvenirNext(size: Style.titleFontSize)
        tipsLabel.textColor = .white
        
        let setCountLabelStackView = UIStackView(arrangedSubviews: [setCountLabel, tipsLabel])
        setCountLabelStackView.alignment = .leading
        setCountLabelStackView.distribution = .fillEqually
        setCountLabelStackView.axis = .vertical
        setCountLabelStackView.spacing = Style.stackViewSpacing
        
        addSubview(setCountLabelStackView)
        setCountLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        setCountLabelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Dimension.edgeInsets.bottom).isActive = true
        setCountLabelStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Style.Dimension.edgeInsets.left).isActive = true
        
        
        let exerciseLabel = UILabel()
        exerciseLabel.text = "Exercise"
        exerciseLabel.font = UIFont.makeAvenirNext(size: Style.titleFontSize)
        exerciseLabel.textColor = .white
        
        exerciseNameLabel.text = workoutViewModel.workoutDetails.exercises[iteration].name.capitalized
        exerciseNameLabel.font = UIFont.makeAvenirNext(size: Style.dataFontSize)//UIFont.systemFont(ofSize: Style.dataFontSize, weight: .semibold)
        exerciseNameLabel.textColor = .white
        
        let exerciseStackView = UIStackView(arrangedSubviews: [exerciseLabel, exerciseNameLabel])
        exerciseStackView.alignment = .leading
        exerciseStackView.distribution = .fillEqually
        exerciseStackView.axis = .vertical
        exerciseStackView.spacing = Style.stackViewSpacing
        
        addSubview(exerciseStackView)
        exerciseStackView.translatesAutoresizingMaskIntoConstraints = false
        exerciseStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Dimension.edgeInsets.bottom).isActive = true
        exerciseStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Style.Dimension.edgeInsets.left).isActive = true
        
        let timeLeftLabel = UILabel()
        timeLeftLabel.text = "Time Remaining"
        timeLeftLabel.font = UIFont.makeAvenirNext(size: Style.titleFontSize)
        timeLeftLabel.textColor = .white
        durationLeftLabel.text = workoutViewModel.workoutDetails.workoutDuration
        durationLeftLabel.font = UIFont.makeAvenirNext(size: Style.dataFontSize)
        durationLeftLabel.textColor = .white
        
        let durationStackView = UIStackView(arrangedSubviews: [timeLeftLabel, durationLeftLabel])
        durationStackView.alignment = .center
        durationStackView.distribution = .fillEqually
        durationStackView.axis = .vertical
        durationStackView.spacing = Style.stackViewSpacing
        
        addSubview(durationStackView)
        durationStackView.translatesAutoresizingMaskIntoConstraints = false
        durationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Style.Dimension.edgeInsets.bottom).isActive = true
        durationStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Style.Dimension.edgeInsets.left).isActive = true
        
        addSubview(videoView)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        videoView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        videoView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        videoView.topAnchor.constraint(equalTo: setCountLabelStackView.bottomAnchor).isActive = true
        videoView.bottomAnchor.constraint(equalTo: durationStackView.topAnchor).isActive = true
        videoView.clipsToBounds = true
//        videoView.playerLayer?.backgroundColor = UIColor.gray.cgColor
//
        runTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WorkoutView {
    enum Style {
          static let titleFontSize: CGFloat = 18
          static let dataFontSize: CGFloat = 22
          static let stackViewSpacing: CGFloat = 4
          
          enum Dimension {
              static let edgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 24, right: 0)
          }
      }
}
