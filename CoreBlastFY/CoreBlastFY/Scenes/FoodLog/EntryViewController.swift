//
//  EntryViewController.swift
//  Journal
//
//  Created by Riccardo Washington on 5/22/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
        setupNavBar()
    }
    
    //MARK: Methods
    
    private func setupViews() {
        view.backgroundColor = .black
        
        view.addSubview(entryTypePicker)
        entryTypePicker.translatesAutoresizingMaskIntoConstraints = false
        entryTypePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Dimensions.topAnchor).isActive = true
        entryTypePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.topAnchor).isActive = true
        entryTypePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.topAnchor).isActive = true
        entryTypePicker.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.topAnchor.constraint(equalTo: entryTypePicker.bottomAnchor, constant: Dimensions.topAnchor).isActive = true
        titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.topAnchor).isActive = true
        titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.topAnchor).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: Dimensions.titleTextFieldHeightAnchor).isActive = true
        
        view.addSubview(bodyTextView)
        bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        bodyTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: Dimensions.topAnchor).isActive = true
        bodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Dimensions.topAnchor).isActive = true
        bodyTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Dimensions.bodyTextViewBottomAnchor).isActive = true
        bodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Dimensions.topAnchor).isActive = true
        
    }
    
    func setupNavBar() {
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(entryUpdate))
        doneButton.tintColor = .goatBlue
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    
    private func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
        let row = entry.entryTypeIndex ?? 0
        entryTypePicker.selectRow(row, inComponent: 0, animated: true)
    }
    
    @objc func entryUpdate() {
        guard let title = titleTextField.text, let bodyText = bodyTextView.text else { return }
        
        let selectedEntryType = entry?.entryType ?? .foodLog
        
        if let entry = entry {
            EntryController.shared.updateEntry(entry: entry, title: title, bodyText: bodyText, entryType: selectedEntryType)
        } else {
            EntryController.shared.createEntry(title: title, bodyText: bodyText, entryType: selectedEntryType)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UI Views
    
    private lazy var titleTextField: UITextField = {
        let titleTF = UITextField()
        titleTF.placeholder = "Title"
        titleTF.delegate = self
        titleTF.font = UIFont.makeAvenirNext(size: UIDevice.isIpad ? 28 : 18)
        titleTF.backgroundColor = .white
        titleTF.clipsToBounds = true
        titleTF.layer.cornerRadius = 8
        return titleTF
    }()
    
    private lazy var bodyTextView: UITextView = {
        let tv = UITextView()
        tv.returnKeyType = .default
        tv.clipsToBounds = true
        tv.layer.cornerRadius = Dimensions.bodyTextViewCornerRadius
        tv.delegate = self
        tv.backgroundColor = UIColor.init(white: 0.8, alpha: 0.2)
        tv.font = UIFont.makeAvenirNext(size: UIDevice.isIpad ? 30 : 20)
        tv.textColor = .white
        return tv
    }()
    
    private lazy var entryTypePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.clipsToBounds = true
        picker.layer.cornerRadius = 8
        picker.backgroundColor = .goatBlue
        picker.dataSource = entryTypePickerDataSource
        picker.delegate = entryTypePickerDelegate
        return picker
    }()
    
    private let entryTypePickerDataSource = EntryTypePickerDataSource()
    private lazy var entryTypePickerDelegate = EntryTypePickerDelegate(callback: { [weak self] entryType in
                                                                        self?.entry?.entryType = entryType})
    
    
    //MARK: - Properties
    
    enum Dimensions {
        static let topAnchor: CGFloat = 16
        static let titleTextFieldHeightAnchor: CGFloat = 50
        static let bodyTextViewCornerRadius: CGFloat = 8
        static let bodyTextViewBottomAnchor: CGFloat = -58
    }
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
}

extension EntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}

extension EntryViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
}

class EntryTypePickerDataSource: NSObject, UIPickerViewDataSource {
    
    private var count = Entry.EntryType.allString.count
    
    func numberOfComponents(in: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_: UIPickerView, numberOfRowsInComponent: Int) -> Int {
        return count
    }

}

class EntryTypePickerDelegate: NSObject, UIPickerViewDelegate {
    
    init(callback: @escaping (Entry.EntryType) -> Void?) {
        self.callback = callback
    }
    
    var callback: (Entry.EntryType) -> Void?
    
    func pickerView(_: UIPickerView, rowHeightForComponent: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_: UIPickerView, titleForRow: Int, forComponent: Int) -> String? {
        return Entry.EntryType.allString[titleForRow]
    }
    
    func pickerView(_: UIPickerView, didSelectRow: Int, inComponent: Int) {
        callback(Entry.EntryType.all[didSelectRow])
    }

}


