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
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            }, completion: nil)
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
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(countDownLabel)
        countDownLabel.translatesAutoresizingMaskIntoConstraints = false
        countDownLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        countDownLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        countDownLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        countDownLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
