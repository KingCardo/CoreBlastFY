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
    let infoLabel = UILabel()
    var pageControl = UIPageControl()
    var forwardButton = UIButton()
    
    var index = 0
    var heading = ""
    var content = ""
    var imageView = UIImageView()
   
    var datePicker = CustomDatePicker()
    var nameTextField = UITextField()
    var date = Date()

    
    private func configureDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(grabInputFromUser), for: .editingDidEnd)
        
        view.addSubview(datePicker)
        datePicker.backgroundColor = .goatBlack
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
    }
    
    private func configureNameTextField() {
        nameTextField.placeholder = "Name"
       // nameTextField.delegate = self
        nameTextField.backgroundColor = .white
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func configureImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "IMG_2308")
    }
    
    @objc func grabInputFromUser(_ sender: UIDatePicker) {
        UserAPI.user.selectedTime = sender.date
        UserManager.save()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
        headingLabel.text = heading
        contentLabel.text = content
        infoLabel.text = "Swipe up or Tap to proceed"
        pageControl.numberOfPages = 5
        pageControl.currentPage = index
        //nameTextField.delegate = self
        
        
        switch index {
        case 0...3: forwardButton.setTitle("NEXT", for: .normal)
        case 4: forwardButton.setTitle("DONE", for: .normal)
        default: break
        }
        
        setupForwardButton()
        
        setupPageControl()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation)))
    }
    
    private func setupLabels() {
        headingLabel.textColor = .white
        headingLabel.font = UIFont.makeTitleFontDB(size: 40)
        headingLabel.numberOfLines = 0
        contentLabel.textColor = .white
        contentLabel.font = UIFont.makeTitleFontDB(size: 22)
        contentLabel.numberOfLines = 0
        
        
        infoLabel.textColor = .white
        infoLabel.font = UIFont.preferredFont(forTextStyle: .callout).withSize(12)
        infoLabel.numberOfLines = 1
    }

    
//     @objc private func handleTapAnimation() {
       // animator.startAnimation()
       // UIView.animate(withDuration: 1.2) {
//            let sizeMultiplier: CGFloat = 2.5
//
//            let newWidth = self.headingLabel.frame.width * sizeMultiplier
//
//            let newHeight = self.headingLabel.frame.height * sizeMultiplier
//
//            let newX = self.headingLabel.frame.origin.x - (newWidth - self.headingLabel.frame.size.width) / 2
//
//            let newY = self.headingLabel.frame.origin.y - (newHeight - self.headingLabel.frame.size.height) / 2
//
//            self.headingLabel.frame = CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
  //      }
        
 //   }

    
    @objc private func handleTapAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
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
                self.infoLabel.alpha = 0

            }) { (_) in
                self.forwardButton.alpha = 1

                if self.index == 4 {
                    self.configureDatePicker()
                      }
            }
        }
    }
    
    private func setupPageControl() {
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .goatBlue
    }
    
    private func setupForwardButton() {
        forwardButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        forwardButton.backgroundColor = .goatBlue
        forwardButton.layer.cornerRadius = 12
        forwardButton.clipsToBounds = true
        forwardButton.alpha = 0
        forwardButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchDown)
    }
  
    
    private func setupUI() {
        setupLabels()
        view.backgroundColor = .goatBlack
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 44).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        view.addSubview(forwardButton)
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        forwardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
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
        
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        infoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        
    }
    
    @objc func nextButtonTapped() {
        switch index {
        case 0...3:
            let pageViewController = parent as! OnboardingPageViewController
            pageViewController.forward(index: index)
            
    
        case 4: //Done Button
            
            grabInputFromUser(datePicker)
            
            UserDefaults.standard.set(true, forKey: onboardingKey)
            
            let homeVC = HomeViewController()
            homeVC.modalPresentationStyle = .fullScreen
            show(homeVC, sender: self)
        default: break
        }
    }
    
    
}

//extension OnboardingViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let user = UserManager.loadUserFromFile()
//        user.name = textField.text!
//        UserManager.save()
//        textField.resignFirstResponder()
//    }
//}
