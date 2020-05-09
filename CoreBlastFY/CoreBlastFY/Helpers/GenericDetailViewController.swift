//
//  GenericDetailViewController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/9/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class GenericDetailViewController: UIViewController {
    
    var data = ""
    
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
        tv.font = UIFont.makeAvenirNext(size: 24)
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
    
    
    private func setup() {
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
        aboutMeTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        aboutMeTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        aboutMeTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        aboutMeTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
    }
}
