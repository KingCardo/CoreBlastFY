//
//  SettingsViewController.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

protocol SettingsDisplayLogic: class {
    func displayItems(viewModel: [Settings.Items.ViewModel.DisplayItem])
}

class SettingsViewController: UITableViewController, SettingsDisplayLogic {
    var interactor: (SettingsBusinessLogic & SettingsDataStore)?
    var router: (NSObjectProtocol & SettingsRoutingLogic & SettingsDataPassing)?
    
    var displayItems: [Settings.Items.ViewModel.DisplayItem] = []
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = SettingsInteractor()
        let presenter = SettingsPresenter()
        let router = SettingsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        setupUI()
    }
    
    //MARK: Routing
    
    private func routeToAboutScene() {
        router?.routeToAboutScene()
    }
    
    private func routeToNotificationsScene() {
        router?.routeToNotificationsScene()
    }
    private func routeToFoodLogScene() {
        router?.routeToFoodLogScene()
    }
    private func routeToParksScene() {
        router?.routeToParksScene()
    }
    
    private func routToTermsOfUse() {
        router?.routeToTermsOfUse()
    }
    
    private func handleRestore() {
        SKPaymentQueue.default().restoreCompletedTransactions()
        AlertController.createAlert(errorMessage: "All successful purchases have been restored.", title: "Success", viewController: self)
        
    }

    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getItems()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "generic")
        
    }
    
    // MARK: Do something
    
    
    func getItems() {
        let request = Settings.Items.Request()
        interactor?.buildItems(request: request)
    }
    
    func displayItems(viewModel: [Settings.Items.ViewModel.DisplayItem]) {
        displayItems = viewModel
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        navigationItem.title = "More"
        tableView.separatorStyle = .none
    }

    override init(style: UITableView.Style) {
        super.init(style: .grouped)
        setup()
    }
    
    // MARK: UITableView DataSource
    
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return displayItems.count
        }
    
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "generic", for: indexPath) as UITableViewCell
            let item = displayItems[indexPath.row]
            cell.textLabel?.text = item.title
            cell.textLabel?.font = UIFont.makeAvenirNext(size: 20)
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .white
            cell.tintColor = .white
            let image = #imageLiteral(resourceName: "forward").withRenderingMode(.alwaysTemplate)
            let forwardImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            forwardImageView.image = image
            cell.accessoryView = forwardImageView
            cell.selectionStyle = .none
            return cell
        }
    
    //MARK: UITableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = interactor?.items[indexPath.row]
        switch item {
        case .about: routeToAboutScene()
        case .notifications: routeToNotificationsScene()
        case .foodLog: routeToFoodLogScene()
      //  case .parks: routeToParksScene()
        case .reportAProblem: contactUsButtonTapped()
        case .inAppPurchase: handleRestore()
        case .termsOfUse: routToTermsOfUse()
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //TO DO: add version number here?
        //TO DO: create reusable view
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        v.backgroundColor = .black
        return v
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
 func contactUsButtonTapped() {
        
        guard MFMailComposeViewController.canSendMail() else { return }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["foreveryoungfitnessX@gmail.com"])
        mailComposer.setSubject("Request a Feature? / Have Feedback? / Report a Bug?") 
        
        present(mailComposer, animated: true)
        if !MFMailComposeViewController.canSendMail() {
            AlertController.createAlert(errorMessage: "Seems like your device can't send emails.", viewController: self)
            return
        }
    }
}
