//
//  Animations.swift
//  FLEXXFIT
//
//  Created by Riccardo Washington on 2/23/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

extension UIView {
    func bounce(duration: CFTimeInterval) {
        let a: CAKeyframeAnimation = {
            func nsNumber(n: Double) -> NSNumber { return NSNumber(value: n) }
            let values: [Double] = [1.0, 0.7, 1.0]
            let keyTimes: [Double] = [0.0, 0.5, 1.0]
            $0.keyPath = "transform.scale"
            $0.values = values.map { $0 }
            $0.keyTimes = keyTimes.map(nsNumber)
            $0.duration = duration
            $0.isRemovedOnCompletion = true
            return $0
        } (CAKeyframeAnimation())
        self.layer.add(a, forKey: "bounce")
    }
    
    func wiggle(duration: CFTimeInterval) {
        let a: CAKeyframeAnimation = {
            func nsNumber(n: Double) -> NSNumber { return NSNumber(value: n) }
            let values: [Double] = [0, 0.2, 0, -0.2, 0]
            let keyTimes: [Double] = [0.0, 0.25, 0.5, 0.75, 1.0]
            $0.keyPath = "position.x"
            $0.values = values.map { $0 }
            $0.keyTimes = keyTimes.map(nsNumber)
            $0.duration = duration
            $0.isRemovedOnCompletion = true
            return $0
        } (CAKeyframeAnimation())
        self.layer.add(a, forKey: "bounce")
        
    }
}
