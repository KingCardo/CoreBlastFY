//
//  Looper.swift
//  Flexx
//
//  Created by Riccardo Washington on 5/14/18.
//  Copyright © 2018 Riccardo Washington. All rights reserved.
//

import UIKit

protocol Looper {
    
    var inProgress: Bool? { get set }
    
    init(videoURLs: [URL], loopCount: Int)
    
    func start(in layer: CALayer)
    
    func stop()
}
