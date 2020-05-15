//
//  LocalNotifications.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/20/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation
import UserNotifications

let center = UNUserNotificationCenter.current()
let notificationsAllowedKey = "notificationsAllowed"
var notificationsAllowed = UserDefaults.standard.bool(forKey: notificationsAllowedKey)

func sendPointDecrementNotification() {
    var dateComponents = DateComponents(calendar: Calendar(identifier: .gregorian))
    dateComponents.hour = 12
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    let content = UNMutableNotificationContent()
    content.title = "It's been over 3 days since completed last workout!"
    content.body = "A point has been deducted for missing 3 consecutive days, complete a workout to gain your point back!"
    content.categoryIdentifier = "lostPointNotification"
    content.sound = UNNotificationSound.default
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
}

func registerForNotifications() {
    
    if !notificationsAllowed {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                mealPrepNotification()
                prepareProgressionPicNotification()
                prepareMFNotification()
                prepareRelaxNotification()
                prepareFriNotification()
                timeToWorkoutMNotification()
                timeToWorkoutTNotification()
                timeToWorkoutWNotification()
                timeToWorkoutTHNotification()
                timeToWorkoutFNotification()
                notificationsAllowed = true
                UserDefaults.standard.set(notificationsAllowed, forKey: notificationsAllowedKey)
            }
        }
    }
}
