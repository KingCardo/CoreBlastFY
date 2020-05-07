//
//  Fonts.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

struct Fonts {
    static var mainFont: UIFont? {
        return UIFont(name: "Avenir Next", size: 30)
    }
    
    static var subFont: UIFont? {
        return UIFont(name: "Avenir Next Condensed", size: 22)
    }
    
    static var woCellFont: UIFont? {
        return UIFont(name: "Avenir Next Condensed", size: 30)
    }
    
}

extension UIFont {
    
    static func makeTitleFont(size: CGFloat) -> UIFont {
        let font = UIFont(name: "AvenirNext-Heavy", size: size)!
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        return fontMetrics.scaledFont(for: font)
        
    }
    static func makeAvenirNext(size: CGFloat) -> UIFont? {
        let font = UIFont(name: "Avenir Next", size: size)!
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        return fontMetrics.scaledFont(for: font)
    }
    
    static func makeAvenirCondensed(size: CGFloat) -> UIFont {
        let font = UIFont(name: "Avenir Next Condensed", size: size)!
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        return fontMetrics.scaledFont(for: font)
    }
    
    static func makeFontSet(size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir Next", size: size)!
    }
    
}
