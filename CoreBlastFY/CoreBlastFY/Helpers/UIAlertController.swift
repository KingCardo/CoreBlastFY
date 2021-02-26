//
//  UIAlertController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/2/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

struct AlertController {
    
    static func createAlert(message: String,
                            title: String,
                            handler1Title: String,
                            handler2Title: String? = nil,
                            handler1: ((UIAlertAction) -> Void)?,
                            handler2: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.overrideUserInterfaceStyle = .dark
        
        let handler1 = UIAlertAction(title: handler1Title, style: .default, handler: handler1)
        let handler2 = UIAlertAction(title: handler2Title, style: .default, handler: handler2)
        
        ac.addAction(handler1)
        ac.addAction(handler2)
        
        return ac
        
    }
    
    static func createAlert(errorMessage: String, title: String = "Oops", viewController: UIViewController, actionTitle: String = "OK", secondActionTitle: String? = nil, handler: ((UIAlertAction) -> Void)? = nil, secondhandler: ((UIAlertAction) -> Void)? = nil) {
        
        let ac = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        ac.overrideUserInterfaceStyle = .dark
        
        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: handler)
        
        if let secondAction = secondActionTitle {
             let secondAction = UIAlertAction(title: secondAction, style: .default, handler: secondhandler)
            ac.addAction(secondAction)
        }
        ac.addAction(okAction)
        
        viewController.present(ac, animated: true)
    
    }
    
    /// Creates and displays an alert.
    
    static func alert(_ title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.overrideUserInterfaceStyle = .dark
        let action = UIAlertAction(title: NSLocalizedString(Messages.okButton, comment: Messages.emptyString),
                                   style: .default, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
