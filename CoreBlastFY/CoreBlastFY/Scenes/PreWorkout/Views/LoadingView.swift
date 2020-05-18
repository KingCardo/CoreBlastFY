//
//  LoadingView.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/13/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
    private var seconds = 3
    private var timer = Timer()
    private var isRunning = false
    private var nextExerciseLabel = UILabel(text: "", font: UIFont.makeTitleFontDB(size: 26), numberOfLines: 0)
    
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
        label.font = UIFont.makeAvenirNext(size: 200)
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.textColor = .white
        return label
    }()
    
     init(frame: CGRect, nextExercise: String = "Get ready first exercise") {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(countDownLabel)
        countDownLabel.fillSuperview()
        
        if !nextExercise.isEmpty {
        nextExerciseLabel.text = "\(nextExercise) is coming up in..."
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
