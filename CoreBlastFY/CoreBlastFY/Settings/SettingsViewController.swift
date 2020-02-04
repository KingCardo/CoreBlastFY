//
//  SettingsViewController.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

   // var sections: [Section]
    
//    func buildSections() {
//        sections = [
//            Section(cells: <#T##[FormCell]#>, headerTitle: <#T##String?#>, isVisible: <#T##Bool#>)
//        ]
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Settings"
       // buildItems()
    }
    
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // var items: [Item] = []
    
//    enum Item {
//        case notifications
//        case nutrition
//        case extras
//        case reminders
//    }
//
//    func buildItems() {
//        items.append(.notifications)
//        items.append(.reminders)
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        <#code#>
//    }

}

//extension SettingsViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let item = items[section]
//        return item.
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell
//        let item = items[indexPath.section]
//
//        switch item {
//        case .notifications:
//            //let c = UITableViewCell(style: .value2, reuseIdentifier: "notificationCell").deq
//            break
//        case .reminders:
//        case .extras, .nutrition:
//            break
//        }
//    }
//
//
//}

