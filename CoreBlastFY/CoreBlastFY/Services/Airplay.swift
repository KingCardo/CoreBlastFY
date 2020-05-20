//
//  Airplay.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/20/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class Airplay {
    static var shared = Airplay()
    
    func registerForNotifications() {
        
    }
    
    func setupPicker(viewController: UIViewController) {
        let volumeView = MPVolumeView()
        //let routePickerView = AVRoutePickerView
        //volumeView.showsRouteButton = true
        volumeView.showsVolumeSlider = false
        volumeView.sizeToFit()
        volumeView.translatesAutoresizingMaskIntoConstraints = false
        
        viewController.view.addSubview(volumeView)
        volumeView.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: 20).isActive = true
        volumeView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: 20).isActive = true
        volumeView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        volumeView.widthAnchor.constraint(equalToConstant: 45).isActive = true
    }
}
