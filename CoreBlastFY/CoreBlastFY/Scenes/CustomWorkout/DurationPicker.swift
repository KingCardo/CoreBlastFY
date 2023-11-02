//
//  DurationPicker.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 7/20/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import UIKit

class DurationPicker: NSObject, UIPickerViewDelegate {
    private let dataSource = [10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90]
    
    var selectedValue: Int? {
        didSet {
            guard let value = selectedValue else { return }
            valueSelected?(value)
        }
    }
    
    var valueSelected: ((Int) -> Void)? 
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: String(dataSource[row]), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = dataSource[row]
        selectedValue = value
    }
    
}

extension DurationPicker: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
}

class NumberOfSecondsRestPicker: NSObject, UIPickerViewDelegate {
    private let dataSource = [5,10,15,20,30]
    
    var selectedValue: Int? {
        didSet {
            guard let value = selectedValue else { return }
            valueSelected?(value)
        }
    }
    
    var valueSelected: ((Int) -> Void)?
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: String(dataSource[row]), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let value = dataSource[row]
        selectedValue = value
    }
    
}

extension NumberOfSecondsRestPicker: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
}
