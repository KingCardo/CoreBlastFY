//
//  String+Extension.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/13/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation

func timeString(time: TimeInterval) -> String {
    let interval = Int(time)
    let seconds = interval % 60
    let minutes = (interval / 60) % 60
    let hour = (interval / 3600)
    return String(format:"%02i:%02i:%02i", hour, minutes, seconds)
    
}
