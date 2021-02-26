//
//  SetPickerDataSource.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 7/20/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class SetPicker: NSObject, UIPickerViewDataSource {
    
    private let numberOfSets = [2,3,4,5,6,7]
    
    var setSelected: ((Int) -> Void)?
    
    var selectedSet: Int? {
        didSet {
            guard let set = selectedSet else { return }
            setSelected?(set)
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfSets.count
    }
    
}

extension SetPicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: String(numberOfSets[row]), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = numberOfSets[row]
        selectedSet = selectedValue
    }
}
