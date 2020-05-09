//
//  WorkoutView.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/13/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

let workoutCompleteNotification = NSNotification.Name("workoutCompleteNotification")

class WorkoutView: UIView {
    
    private var setNumber = 1
    private var iteration = 0
    private var workoutDuration: TimeInterval
    
    weak var rootViewController: WorkoutViewController?
    private var workoutViewModel: WorkoutInfo.FetchWorkout.ViewModel
    
    private let setCountLabel = UILabel()
    private let tipsLabel = UILabel()
    private let durationLeftLabel = UILabel()
    private let exerciseNameLabel = UILabel()
    private var workoutTimer = Timer()
    var timerIsRunning = false
    
    private var videoView: VideoView?
    
    private var exercises: [Exercise]
    private let setDuration: TimeInterval
    private let exerciseDuration: TimeInterval
    
    private var numberOfSets: Int {
        guard let number = Int(workoutViewModel.workoutDetails.numberOfSets) else { return 4 }
        return number
    }
    
    @objc func fireRestTimer() {
        if setNumber < numberOfSets {
            setNumber += 1
            setCountLabel.text = "Set \(setNumber) of \(workoutViewModel.workoutDetails.numberOfSets)"
            //TO DO: - make reusable
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
    
    func runTimer() {
        workoutTimer = Timer.scheduledTimer(timeInterval: 0.95, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timerIsRunning = true
    }
    
    @objc private func fireTimer() {
        if workoutDuration > 1 {
            workoutDuration -= 1
            durationLeftLabel.text = timeString(time: workoutDuration)
            
            if workoutDuration.truncatingRemainder(dividingBy: setDuration) == 0 {
                fireRestTimer()
            }
            if workoutDuration.truncatingRemainder(dividingBy: exerciseDuration) == 0 {
                fireExerciseTimer()
            }
            
        } else {
            workoutFinished()
        }
    }
    
    func resumeWorkout() {
        runTimer()
        videoView?.resume()
    }
    
    func pauseWorkout() {
        invalidateTimers()
        videoView?.pauseVideo()
    }
    
    private func invalidateTimers() {
        timerIsRunning = false
        workoutTimer.invalidate()
    }
    
    func workoutFinished() {
        UserManager.incrementPoint()
        UserManager.calculateLevel(totalPoints: UserAPI.user.totalPoints)
        videoView = nil
        invalidateTimers()
        workoutComplete()
    }
    
    private func updateExerciseViews() {
        tipsLabel.text = workoutViewModel.workoutDetails.exercises[iteration].tip.capitalized
        exerciseNameLabel.text = workoutViewModel.workoutDetails.exercises[iteration].name.capitalized
        videoView?.advanceToNextItem()
    }
    
    var workoutComplete = {
        NotificationCenter.default.post(name: workoutCompleteNotification, object: nil)
    }
    
    init(frame: CGRect, rootVC: UIViewController, viewModel: WorkoutInfo.FetchWorkout.ViewModel) {
        rootViewController = rootVC as? WorkoutViewController
        workoutViewModel = viewModel
        workoutDuration = workoutViewModel.workoutDetails.workoutDurationDouble
        
        exercises = workoutViewModel.workoutDetails.exercises
        exerciseDuration = workoutViewModel.workoutDetails.secondsOfExercise
        setDuration = workoutViewModel.workoutDetails.setDuration
        let videoUrls: [URL] = workoutViewModel.workoutDetails.exercises.compactMap {  $0.videoURL }
        super.init(frame: frame)
        videoView = VideoView(frame: frame, urls: videoUrls, loopCount: -1, numberOfSets:  Int(workoutViewModel.workoutDetails.numberOfSets) ?? 4)
        
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
        setCountLabelStackView.backgroundColor = .clear
        
        addSubview(setCountLabelStackView)
        setCountLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        setCountLabelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Dimension.edgeInsets.bottom).isActive = true
        setCountLabelStackView.topAnchor.constraint(equalTo: topAnchor, constant: Style.stackViewTop).isActive = true
        
        let exerciseLabel = UILabel()
        exerciseLabel.text = "Exercise"
        exerciseLabel.font = UIFont.makeAvenirNext(size: Style.titleFontSize)
        exerciseLabel.textColor = .white
        
        exerciseNameLabel.text = workoutViewModel.workoutDetails.exercises[iteration].name.capitalized
        exerciseNameLabel.font = UIFont.makeAvenirNext(size: Style.dataFontSize)
        exerciseNameLabel.textColor = .white
        
        let exerciseStackView = UIStackView(arrangedSubviews: [exerciseLabel, exerciseNameLabel])
        exerciseStackView.alignment = .leading
        exerciseStackView.distribution = .fillEqually
        exerciseStackView.axis = .vertical
        exerciseStackView.spacing = Style.stackViewSpacing
        exerciseStackView.backgroundColor = .clear
        
        addSubview(exerciseStackView)
        exerciseStackView.translatesAutoresizingMaskIntoConstraints = false
        exerciseStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Dimension.edgeInsets.bottom).isActive = true
        exerciseStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Style.Dimension.edgeInsets.right).isActive = true
        
        let timeLeftLabel = UILabel()
        timeLeftLabel.text = "Time Remaining"
        timeLeftLabel.font = UIFont.makeAvenirNext(size: Style.titleFontSize)
        timeLeftLabel.textColor = .white
        durationLeftLabel.text = workoutViewModel.workoutDetails.workoutDuration
        durationLeftLabel.font = UIFont.makeAvenirNext(size: Style.dataFontSize)
        durationLeftLabel.textColor = .white
        //durationLeftLabel.backgroundColor = .black
        
        let durationStackView = UIStackView(arrangedSubviews: [timeLeftLabel, durationLeftLabel])
        durationStackView.alignment = .center
        durationStackView.distribution = .fillEqually
        durationStackView.axis = .vertical
        durationStackView.spacing = Style.stackViewSpacing
        durationStackView.backgroundColor = .clear
        
        addSubview(durationStackView)
        durationStackView.translatesAutoresizingMaskIntoConstraints = false
        durationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Style.Dimension.edgeInsets.left).isActive = true
        durationStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Style.Dimension.edgeInsets.right).isActive = true
        
        guard let videoView = videoView else { return }
        
        addSubview(videoView)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        videoView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        videoView.topAnchor.constraint(equalTo: setCountLabelStackView.bottomAnchor, constant: Style.stackViewTop).isActive = true
        videoView.bottomAnchor.constraint(equalTo: durationStackView.topAnchor, constant: -Style.stackViewTop).isActive = true
        videoView.bounds = videoView.frame
        videoView.playVideo()
        
        runTimer()
    }
    
    func setupVideoView(frame: CGRect, urls: [URL], numberOfSets: Int) {
        videoView = VideoView(frame: frame, urls: urls, loopCount: -1, numberOfSets: numberOfSets)
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
        static let stackViewTop: CGFloat = 8
        
        enum Dimension {
            static let edgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 24, right: 44)
        }
    }
}
