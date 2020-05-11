//
//  AboutMeViewController.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/29/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {
    
    private let data = "Welcome To Forever Young Fitness! Im glad you found you're way here. My name is Franchiz and being a former college football player, and personal trainer in the soCal area I was able to learn alot of different things by working with so many people from so many backgrounds. Everybody wants to look and feel their best but maybe don't know the steps to get there, or can't find a way to stay consistent long enough to get results. That's why I made this app, to help everyone look and feel their best so that you can be proof, age is just a number. I like to always try and answer questions so don't hesitate to email or reach out on the fitness page @f.orevery.oungf.itness. Welcome to the Forever Young Family!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    lazy var aboutMeTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isSelectable = false
        tv.text = data
        tv.textColor = .white
        tv.font = UIFont.makeAvenirNext(size: 20)
        tv.backgroundColor = .clear
        return tv
    }()
    
    let aboutMeImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "6packFY")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
    
    
    func setup() {
        view.addSubview(aboutMeImageView)
        aboutMeImageView.translatesAutoresizingMaskIntoConstraints = false
        aboutMeImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        aboutMeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        aboutMeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        aboutMeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
  
        
        view.addSubview(aboutMeTextView)
        aboutMeTextView.translatesAutoresizingMaskIntoConstraints = false
        aboutMeTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        aboutMeTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        aboutMeTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        aboutMeTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
    }
}
