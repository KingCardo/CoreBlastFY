//
//  LoadingViewController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 3/7/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
NotificationCenter.default.addObserver(self, selector: #selector(showWorkoutVC), name: NSNotification.Name("ExercisesLoadedNotification"), object: nil)
        setUpLoadingLabel()
        
    }
    
    let loadingLabel = UILabel()
    private var loadingSpinner: UIActivityIndicatorView?
    
    private func displayLoadingSpinner() {
        loadingSpinner = UIActivityIndicatorView(style: .large)
        loadingSpinner?.color = .lightGray
        loadingSpinner?.startAnimating()
        view.addSubview(loadingSpinner!)
        
        loadingSpinner?.translatesAutoresizingMaskIntoConstraints = false
        loadingSpinner?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingSpinner?.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        
    }
    
    private func setUpLoadingLabel() {
        view.backgroundColor = .white
        loadingLabel.text = "Downloading Programs..."
        loadingLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        view.addSubview(loadingLabel)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        displayLoadingSpinner()
    }
    
    @objc private func showWorkoutVC() {
        loadingSpinner?.stopAnimating()
        loadingSpinner = nil
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        show(homeVC, sender: self)
    
    }

}