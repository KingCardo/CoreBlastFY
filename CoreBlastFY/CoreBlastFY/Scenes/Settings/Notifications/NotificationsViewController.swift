//
//  NotificationsViewController.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 4/13/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NotificationsDisplayLogic: class {
  func displaySelectedTime(viewModel: Notifications.SelectedTime.ViewModel)
}

class NotificationsViewController: UIViewController, NotificationsDisplayLogic {
  var interactor: NotificationsBusinessLogic?
  var router: (NSObjectProtocol & NotificationsRoutingLogic & NotificationsDataPassing)?

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
    let interactor = NotificationsInteractor()
    let presenter = NotificationsPresenter()
    let router = NotificationsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getNotificationTime()
  }
  
  // MARK: Do something
    
    private let datePicker = CustomDatePicker()
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .goatBlue
        button.addTarget(self, action: #selector(grabDate), for: .touchDown)
        return button
    }()
        
    @objc func grabDate() {
        UserAPI.user.selectedTime = datePicker.date
        UserManager.save()
        NotificationIDs.removeNotification(ids: NotificationIDs.allIDs)
        let user = UserManager.loadUserFromFile()
        NotificationIDs.prepareNotification(id: NotificationIDs.mondayID, weekday: 2, hour: user.selectedHour ?? 12, minute: user.selectedMinute ?? 0)
        NotificationIDs.prepareNotification(id: NotificationIDs.tuesdayID, weekday: 3, hour: user.selectedHour ?? 12, minute: user.selectedMinute ?? 0)
        NotificationIDs.prepareNotification(id: NotificationIDs.wednesdayID, weekday: 4, hour: user.selectedHour ?? 12, minute: user.selectedMinute ?? 0)
        NotificationIDs.prepareNotification(id: NotificationIDs.thursdayID, weekday: 5, hour: user.selectedHour ?? 12, minute: user.selectedMinute ?? 0)
        NotificationIDs.prepareNotification(id: NotificationIDs.fridayID, weekday: 6, hour: user.selectedHour ?? 12, minute: user.selectedMinute ?? 0)
        navigationController?.popViewController(animated: true)
    }
    
  func getNotificationTime() {
    let request = Notifications.SelectedTime.Request()
    interactor?.getNotificationTime(request: request)
  }
  
  func displaySelectedTime(viewModel: Notifications.SelectedTime.ViewModel) {
    configureDatePicker()
    datePicker.date = viewModel.selectedDate
  }
    private func configureDatePicker() {
        datePicker.datePickerMode = .time
        
        view.addSubview(datePicker)
        datePicker.backgroundColor = .goatBlack
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: NotificationsViewController.Dimensions.datePickerHeight).isActive = true
    
   
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: NotificationsViewController.Dimensions.doneButton.bottom).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: NotificationsViewController.Dimensions.doneButton.top).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: view.frame.width * NotificationsViewController.Dimensions.doneButton.left).isActive = true
        doneButton.layer.cornerRadius = NotificationsViewController.Dimensions.doneButtonCornerRadius
    }
}

extension NotificationsViewController {
    struct Dimensions {
        static let datePickerHeight: CGFloat = 250
        static let doneButton = UIEdgeInsets(top: 50, left: 0.75, bottom: -100, right: 0)
        static let doneButtonCornerRadius: CGFloat = 25
    }
}
