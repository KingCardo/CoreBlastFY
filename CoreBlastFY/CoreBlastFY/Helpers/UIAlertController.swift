//
//  UIAlertController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/2/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

struct AlertController {
    
    static func createAlert(errorMessage: String, title: String = "Oops", viewController: UIViewController) {
        let ac = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        ac.addAction(okAction)
        viewController.present(ac, animated: true)
    }
}
