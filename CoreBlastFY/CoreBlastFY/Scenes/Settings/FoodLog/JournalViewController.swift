//
//  JournalViewController.swift
//  Journal
//
//  Created by Riccardo Washington on 5/22/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit

class JournalViewController: UIViewController {
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                if EntryController.shared.entries.count > 0 {
                    journalTableView.reloadData()
                }
    }
    
    //MARK: - Methods
    
    private func setupTableView() {
        view.addSubview(journalTableView)
        journalTableView.backgroundColor = .black
        journalTableView.register(EntryCell.self, forCellReuseIdentifier: journalcellId)
        journalTableView.translatesAutoresizingMaskIntoConstraints = false
        journalTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        journalTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        journalTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        journalTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        setupButton()
    }
    
    func setupNavBar() {
        navigationItem.title = "Food Log"
    }
    
    var createEntryButton = UIButton()
    
    func setupButton() {
        createEntryButton.contentVerticalAlignment = .fill
        createEntryButton.contentHorizontalAlignment = .fill
        let image = UIImage(systemName: "plus.circle.fill")?.withRenderingMode(.alwaysTemplate)
        createEntryButton.setImage(image, for: .normal)
        createEntryButton.addTarget(self, action: #selector(createNewEntry), for: .touchDown)
        createEntryButton.tintColor = .goatBlue
        
        view.addSubview(createEntryButton)
        createEntryButton.translatesAutoresizingMaskIntoConstraints = false
        createEntryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        createEntryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        createEntryButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        createEntryButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    @objc func createNewEntry() {
        let entryVc = EntryViewController()
        navigationController?.pushViewController(entryVc, animated: true)
    }
    
    //MARK: - UI Views
    
    private lazy var journalTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    //MARK: - Properties
    
    private let journalcellId = "journalcellId"
    
    enum Dimensions {
        static let tableViewHeight: CGFloat = 80
    }
}


//MARK: - UITableView Delegate & DataSource

extension JournalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Dimensions.tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let entryVc = EntryViewController()
        entryVc.entry = EntryController.shared.entries[indexPath.row]
        navigationController?.pushViewController(entryVc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entry = EntryController.shared.entries[indexPath.row]
            EntryController.shared.deleteEntry(entry: entry)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
extension JournalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: journalcellId, for: indexPath) as! EntryCell
        let entry = EntryController.shared.entries[indexPath.row]
        cell.entry = entry
        return cell
    }
    
    
}

