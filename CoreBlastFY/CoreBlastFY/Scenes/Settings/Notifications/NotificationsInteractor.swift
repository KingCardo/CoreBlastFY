//
//  NotificationsInteractor.swift
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

protocol NotificationsBusinessLogic {
  func getNotificationTime(request: Notifications.SelectedTime.Request)
}

protocol NotificationsDataStore {
}

class NotificationsInteractor: NotificationsBusinessLogic, NotificationsDataStore {
  var presenter: NotificationsPresentationLogic?
  var worker: NotificationsWorker?
 
  
  // MARK: Do something
  
  func getNotificationTime(request: Notifications.SelectedTime.Request) {
    worker = NotificationsWorker()
    worker?.fetchSelectedTime(completion: { selectedTime in
        let response = Notifications.SelectedTime.Response(selectedDate: selectedTime)
        self.presenter?.presentSelectedTime(response: response)
    })
  }
}
