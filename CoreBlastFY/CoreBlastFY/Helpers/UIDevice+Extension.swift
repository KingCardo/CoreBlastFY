//
//  UIDevice+Extension.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/23/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

extension UIDevice {
    static var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
