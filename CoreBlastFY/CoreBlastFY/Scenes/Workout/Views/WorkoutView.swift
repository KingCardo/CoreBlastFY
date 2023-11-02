//
//  WorkoutView.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/13/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

let workoutCompleteNotification = NSNotification.Name("workoutCompleteNotification")
let workoutCompleteNotification2 = NSNotification.Name("workoutCompleteNotification2")

class WorkoutView: UIView {
    
    private var setNumber = 1
    private var iteration = 0
    private var workoutDuration: TimeInterval
    var timerIsRunning = false
    
    weak var rootViewController: WorkoutViewController?
    private var workoutViewModel: WorkoutInfo.FetchWorkout.ViewModel
    
    private let pauseLabel = UILabel.init(text: "PAUSED", font: UIFont.makeTitleFont(size: UIDevice.isIpad ? 40 : 30), numberOfLines: 0)
    private let setCountLabel = UILabel()
    private let tipsLabel = UILabel()
    private let instructionsLabel = UILabel()
    private let durationLeftLabel = UILabel()
    private let exerciseNameButton = UIButton()
    private let timeLeftLabel = UILabel()
    private var workoutTimer = Timer()
   
    
    var loadingView: LoadingView?
    
    private var videoView: VideoView?
    
    private var exercises: [Exercise]
    private let setDuration: TimeInterval
    private let exerciseDuration: TimeInterval
    private let secondsOfRest: Int
    
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
    
    private func runTimer() {
        workoutTimer = Timer.scheduledTimer(timeInterval: 0.99, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
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
        DispatchQueue.main.async { [weak self] in
            self?.pauseLabel.isHidden = true
            self?.durationLeftLabel.isHidden = false
            self?.timeLeftLabel.isHidden = false
            self?.runTimer()
            self?.videoView?.resume()
            self?.setNeedsDisplay()
            self?.setNeedsLayout()
        }
    }
    
    func pauseWorkout() {
        DispatchQueue.main.async { [weak self] in
            self?.pauseLabel.isHidden = false
            self?.durationLeftLabel.isHidden = true
            self?.timeLeftLabel.isHidden = true
            self?.invalidateTimers()
            self?.videoView?.pauseVideo()
            self?.setNeedsDisplay()
            self?.setNeedsLayout()
        }
    }
    
    private func pauseWorkoutForTransition() {
        DispatchQueue.main.async { [weak self] in
            self?.invalidateTimers()
            self?.hideLabelsForTransition()
            self?.videoView?.advanceToNextItem()
            self?.setNeedsDisplay()
            self?.setNeedsLayout()
        }
    }
    
    func runTimersForTransition() {
        invalidateTimers()
        
    }
    
    private func resumeWorkoutForTransition() {
        DispatchQueue.main.async { [weak self] in
            self?.showLabelsAfterTransition()
            self?.runTimer()
            self?.setNeedsDisplay()
            self?.setNeedsLayout()
        }
    }
    
    private func hideLabelsForTransition() {
        tipsLabel.isHidden = true
        instructionsLabel.isHidden = true
        setCountLabel.isHidden = true
        exerciseNameButton.isHidden = true
        timeLeftLabel.isHidden = true
        durationLeftLabel.isHidden = true
    }
    
    private func showLabelsAfterTransition() {
        tipsLabel.isHidden = false
        instructionsLabel.isHidden = false
        setCountLabel.isHidden = false
        exerciseNameButton.isHidden = false
        timeLeftLabel.isHidden = false
        durationLeftLabel.isHidden = false
    }
    
    private func invalidateTimers() {
        timerIsRunning = false
        workoutTimer.invalidate()
    }
    
    private func workoutFinished() {
        UserManager.incrementPoint()
        UserManager.calculateLevel(totalPoints: UserAPI.user.totalPoints)
        videoView = nil
        invalidateTimers()
        workoutComplete()
    }
    
    private func updateExerciseViews() {
        
        let nextExercise = workoutViewModel.workoutDetails.exercises[iteration].name.capitalized
        let tipsText = workoutViewModel.workoutDetails.exercises[iteration].tip.capitalized
        tipsLabel.text = tipsText
        exerciseNameButton.setTitle(nextExercise, for: .normal)
        
        loadingView = LoadingView(frame: .zero, nextExercise: nextExercise, secondsOfRest: secondsOfRest)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            if let loadingView = self?.loadingView {
                self?.pauseWorkoutForTransition()
                self?.addSubview(loadingView)
                loadingView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: -100, right: 0))
            }
        }) { (true) in
            self.loadingView!.runTimer { [weak self] in
                self?.loadingView?.removeFromSuperview()
                self?.resumeWorkoutForTransition()
                self?.loadingView = nil
                SpeechSynthesizer.shared.textToSpeak(text: tipsText)
            }
        }
    }
    
    var workoutComplete = {
        NotificationCenter.default.post(name: workoutCompleteNotification, object: nil)
    }
    
    init(frame: CGRect, rootVC: UIViewController, viewModel: WorkoutInfo.FetchWorkout.ViewModel, secondsOfRest: Int) {
        rootViewController = rootVC as? WorkoutViewController
        workoutViewModel = viewModel
        workoutDuration = workoutViewModel.workoutDetails.workoutDurationDouble
        self.secondsOfRest = secondsOfRest
        
        let screenHeight = UIScreen.main.bounds.height
        
        exercises = workoutViewModel.workoutDetails.exercises
        exerciseDuration = workoutViewModel.workoutDetails.secondsOfExercise
        setDuration = workoutViewModel.workoutDetails.setDuration
        let videoUrls: [URL] = workoutViewModel.workoutDetails.exercises.compactMap {  $0.videoURL }
        super.init(frame: frame)
        videoView = VideoView(frame: frame, urls: videoUrls, loopCount: -1, numberOfSets:  Int(workoutViewModel.workoutDetails.numberOfSets) ?? 4)
        
        backgroundColor = .black
        
        setCountLabel.font = UIDevice.isIpad ? UIFont.makeTitleFontDB(size: 28) : UIFont.makeTitleFontDB(size: Style.titleFontSize)
        setCountLabel.textColor = .white
        
        setCountLabel.text = "Set \(setNumber) of \(workoutViewModel.workoutDetails.numberOfSets)"

        
        let icon = #imageLiteral(resourceName: "muscleflex").withRenderingMode(.alwaysTemplate)
        
       
        exerciseNameButton.setImage(icon, for: .normal)
        exerciseNameButton.imageView?.tintColor = UIColor.goatBlue
        exerciseNameButton.backgroundColor = UIColor.goatBlack.withAlphaComponent(0.7)
        exerciseNameButton.imageView?.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        exerciseNameButton.contentEdgeInsets  = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        exerciseNameButton.layer.cornerRadius = 9
        exerciseNameButton.setTitle(workoutViewModel.workoutDetails.exercises[iteration].name.capitalized, for: .normal)
        exerciseNameButton.titleLabel?.font = UIDevice.isIpad ? UIFont.makeAvenirNext(size: 32) : UIFont.makeAvenirNext(size: Style.titleFontSize)
        
        let setAndExerciseContainerStackView = UIStackView(arrangedSubviews: [setCountLabel, exerciseNameButton])
        setAndExerciseContainerStackView.distribution = .equalSpacing
        setAndExerciseContainerStackView.backgroundColor = .clear
        
        
        guard let videoView = videoView else { return }
        addSubview(videoView)
        
        videoView.translatesAutoresizingMaskIntoConstraints = false
        videoView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        videoView.topAnchor.constraint(equalTo: topAnchor, constant: -(frame.height * 0.2)).isActive = true
        videoView.heightAnchor.constraint(equalToConstant: frame.height * 0.83).isActive = true
        videoView.bounds = videoView.frame
        
        let instructions = "Tips for success"
        instructionsLabel.text = instructions
        instructionsLabel.numberOfLines = 0
        instructionsLabel.font = UIDevice.isIpad ? UIFont.makeTitleFontDB(size: 28) : UIFont.makeTitleFontDB(size: Style.titleFontSize)
        instructionsLabel.textColor = .white
        
        let tipsText = workoutViewModel.workoutDetails.exercises[iteration].tip.capitalized
        tipsLabel.text = tipsText
        tipsLabel.numberOfLines = 0
        tipsLabel.font = UIDevice.isIpad ? UIFont.makeTitleFontDB(size: 28) : UIFont.makeTitleFontDB(size: Style.titleFontSize)
        tipsLabel.textColor = .white.withAlphaComponent(0.8)
        
        
        let tipsStackView = UIStackView(arrangedSubviews: [instructionsLabel, tipsLabel])
        tipsStackView.alignment = .leading
        tipsStackView.distribution = .fillEqually
        tipsStackView.axis = .vertical
        tipsStackView.spacing = Style.stackViewSpacing
        tipsStackView.backgroundColor = .clear
        
        
        timeLeftLabel.text = "Time Remaining"
        timeLeftLabel.font = UIDevice.isIpad ? UIFont.makeAvenirNext(size: 28) : UIFont.makeAvenirNext(size: Style.titleFontSize)
        timeLeftLabel.textColor = .white.withAlphaComponent(0.8)
        durationLeftLabel.text = workoutViewModel.workoutDetails.workoutDuration
        durationLeftLabel.font = UIDevice.isIpad ? UIFont.makeTitleFontDB(size: 52) : UIFont.makeTitleFontDB(size: 42)
        durationLeftLabel.textColor = .white
        
        let durationStackView = UIStackView(arrangedSubviews: [timeLeftLabel, durationLeftLabel])
        durationStackView.alignment = .center
        durationStackView.distribution = .fillProportionally
        durationStackView.axis = .vertical
       // durationStackView.spacing = Style.stackViewSpacing
        durationStackView.backgroundColor = .clear

        
        addSubview(setAndExerciseContainerStackView)
        setAndExerciseContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        setAndExerciseContainerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Dimension.edgeInsets.bottom).isActive = true
        setAndExerciseContainerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Style.Dimension.edgeInsets.left).isActive = true
        setAndExerciseContainerStackView.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: screenHeight * 0.02).isActive = true
        
        addSubview(tipsStackView)
        tipsStackView.translatesAutoresizingMaskIntoConstraints  = false
        tipsStackView.topAnchor.constraint(equalTo: setAndExerciseContainerStackView.bottomAnchor, constant: screenHeight * 0.02).isActive = true
        tipsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Dimension.edgeInsets.bottom).isActive = true
        tipsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Style.Dimension.edgeInsets.bottom).isActive = true
        
        
        
        addSubview(durationStackView)
        durationStackView.translatesAutoresizingMaskIntoConstraints  = false
        durationStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Dimension.edgeInsets.left).isActive = true
        durationStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Style.Dimension.edgeInsets.right).isActive = true
        durationStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Style.Dimension.edgeInsets.left).isActive = true
    
        
        
        videoView.playVideo()
        
        SpeechSynthesizer.shared.textToSpeak(text: tipsText)
        
        videoView.addSubview(pauseLabel)
        pauseLabel.centerYInSuperview()
        pauseLabel.centerXInSuperview()
        pauseLabel.textColor = .white
        pauseLabel.isHidden = true
        
        runTimer()
    }
    
    func setupVideoView(frame: CGRect, urls: [URL], numberOfSets: Int) {
        videoView = VideoView(frame: frame, urls: urls, loopCount: -1, numberOfSets: numberOfSets)
    }
    
    required init?(coder: NSCoder) {
        return nil
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
