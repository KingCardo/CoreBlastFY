//
//  LoadingView.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/13/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    private var seconds = 5
    private var timer = Timer()
    private var isRunning = false
    private var nextExerciseLabel = UILabel(text: "", font: UIDevice.isIpad ? UIFont.makeTitleFontDB(size: 36) : UIFont.makeTitleFontDB(size: 26), numberOfLines: 0)
    
    func runTimer(completion: @escaping(() -> Void)) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        isRunning = true
        dismissedCompletion = {
            completion()
        }
    }
    
    var dismissedCompletion: (() -> Void)?
    
    @objc private func updateLabel() {
        
        if seconds < 1 {
            timer.invalidate()
            seconds = 3
            isRunning = false
            dismissedCompletion?()
        } else {
            countDownLabel.text = "\(seconds)"
            seconds -= 1
        }
    }
    
    private let countDownLabel: UILabel = {
        let label = UILabel()
        label.font = UIDevice.isIpad ? UIFont.makeAvenirNext(size: 300) : UIFont.makeAvenirNext(size: 200)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        return label
    }()
    
    init(frame: CGRect, nextExercise: String = "Get ready first exercise", backgroundColor: UIColor = .clear) {
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        addSubview(countDownLabel)
        countDownLabel.fillSuperview(padding: UIEdgeInsets(top: UIDevice.isIpad ? 100 : 50, left: 0, bottom: 0, right: 0))
        
        if !nextExercise.isEmpty {
            let textToSpeak = "\(nextExercise) is coming up"
            SpeechSynthesizer.shared.textToSpeak(text: textToSpeak)
            nextExerciseLabel.text = textToSpeak
            nextExerciseLabel.textColor = .white
            nextExerciseLabel.textAlignment = .center
            addSubview(nextExerciseLabel)
            nextExerciseLabel.translatesAutoresizingMaskIntoConstraints = false
            nextExerciseLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
            nextExerciseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
            nextExerciseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
