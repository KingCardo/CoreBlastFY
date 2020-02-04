//
//  OnboardingViewController.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit
import AVFoundation

let onboardingKey = "hasViewedWalkThrough"

class OnboardingViewController: UIViewController {
    
    var headingLabel = UILabel()
    var contentLabel = UILabel()
    var contentImageView = UIImageView()
    var pageControl = UIPageControl()
    var forwardButton = UIButton()
    var videoView = UIView()
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    var progressBar = UIProgressView()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLabels()
        view.backgroundColor = .goatBlack
        headingLabel.text = heading
        contentLabel.text = content
        pageControl.numberOfPages = 4
        pageControl.currentPage = index
        
        
        switch index {
        case 0...2: forwardButton.setTitle("NEXT", for: .normal)
        case 3: forwardButton.setTitle("DONE", for: .normal)
        default: break
        }
        
        setupForwardButton()
        forwardButton.alpha = 0
        setupPageControl()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation)))
    }
    
    private func setupLabels() {
        headingLabel.textColor = .white
        headingLabel.font = UIFont.boldSystemFont(ofSize: 40)
        headingLabel.numberOfLines = 0
        contentLabel.textColor = .white
        contentLabel.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        contentLabel.numberOfLines = 0
    }
    
    @objc private func handleTapAnimation() {
        if index == 3 {
            print("RWRWRW, this is the right page")
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.headingLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                self.headingLabel.alpha = 0
                self.headingLabel.transform = self.headingLabel.transform.translatedBy(x: 0, y: -250)
            })
        }
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.contentLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                self.contentLabel.alpha = 0
                self.contentLabel.transform = self.contentLabel.transform.translatedBy(x: 0, y: -350)
                
            }) { (_) in
                self.forwardButton.alpha = 1
            }
        }
    }
    
    private func setupPageControl() {
        pageControl.pageIndicatorTintColor = .goatBlack
        pageControl.currentPageIndicatorTintColor = .goatBlue
    }
    
    private func setupForwardButton() {
        forwardButton.backgroundColor = .goatBlue
        forwardButton.layer.cornerRadius = 12
        forwardButton.clipsToBounds = true
        forwardButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchDown)
    }
  
    
    private func setupUI() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 44).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        view.addSubview(forwardButton)
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        forwardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        forwardButton.widthAnchor.constraint(equalToConstant: 74).isActive = true
        forwardButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        view.addSubview(headingLabel)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 220).isActive = true
        headingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        headingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        view.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 40).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
    }
    
    @objc func nextButtonTapped() {
        switch index {
        case 0...2:
            let pageViewController = parent as! OnboardingPageViewController
            pageViewController.forward(index: index)
            
        case 3: //Done Button
            
            //validate stuff from textfields and pickers
            
            
            
            
            UserDefaults.standard.set(true, forKey: onboardingKey)
                let homeVC = HomeViewController()
               if let appDelegate = UIApplication.shared.delegate,
                            let appWindow = appDelegate.window!
                             {
                                appWindow.rootViewController = homeVC
                            //rootViewController.present(homeVC, animated: true, completion: nil)
                        }
            
            dismiss(animated: true, completion: nil)
        default: break
        }
    }
    
    
}
