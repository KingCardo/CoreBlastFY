//
//  LoadingViewController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/28/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(showWorkoutVC), name: NSNotification.Name("ExercisesLoadedNotification"), object: nil)
        setUpLoadingLabel()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLabel()
        
    }
    
    private func animateLabel() {
        UIView.animate(withDuration: 3, animations: { [weak self] in
            self?.loadingLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self?.loadingLabel.transform = .identity
        }) { (Success) in
            UIView.animate(withDuration: 3, animations: { [weak self] in
                self?.loadingLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                self?.loadingLabel.transform = .identity
            }) { (Success) in
                UIView.animate(withDuration: 3, animations: { [weak self] in
                    self?.loadingLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                    self?.loadingLabel.transform = .identity
                }) { (Success) in
                    UIView.animate(withDuration: 3, animations: { [weak self] in
                        self?.loadingLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                        self?.loadingLabel.transform = .identity
                    }) { (Success) in
                        UIView.animate(withDuration: 3, animations: { [weak self] in
                            self?.loadingLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                            self?.loadingLabel.transform = .identity
                        }) { (Success) in
                            AlertController.createAlert(errorMessage: "Still fetching, maybe connect to Wifi for faster program dowload.", title: "Download still in progress", viewController: self, actionTitle: "OK")
                        }
                    }
                }
            }
        }
        
    }

    let loadingLabel = UILabel()
    let loadingIV = UIImageView(image: #imageLiteral(resourceName: "inapppromopic"))
    private var loadingSpinner: UIActivityIndicatorView?

    private func displayLoadingSpinner() {
        loadingSpinner = UIActivityIndicatorView(style: .large)
        loadingSpinner?.color = .white
        loadingSpinner?.startAnimating()
        view.addSubview(loadingSpinner!)

        loadingSpinner?.translatesAutoresizingMaskIntoConstraints = false
        loadingSpinner?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingSpinner?.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true

    }

    private func setUpLoadingLabel() {
        view.backgroundColor = .black
        view.addSubview(loadingIV)
        loadingIV.contentMode = .scaleAspectFit
        loadingIV.fillSuperview()
        loadingLabel.text = "Downloading Programs..."
        loadingLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        loadingLabel.textColor = .white
        loadingLabel.backgroundColor = .clear
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