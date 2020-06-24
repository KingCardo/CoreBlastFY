//
//  LocalNotifications.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/20/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation
import UserNotifications

let notificationsAllowedKey = "notificationsAllowed"
var notificationsAllowed = UserDefaults.standard.bool(forKey: notificationsAllowedKey)

let decrementNotifId = UUID().uuidString

func sendPointDecrementNotification() {
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    
    let content = UNMutableNotificationContent()
    content.title = "It's been over 3 days since completed last workout!"
    content.body = "A point has been deducted for missing 3 consecutive days, complete a workout to gain your point back!"
    content.categoryIdentifier = "lostPointNotification"
    content.sound = UNNotificationSound.default
    
    let request = UNNotificationRequest(identifier: decrementNotifId, content: content, trigger: trigger)
    notificationCenter.add(request)
}

func registerForNotifications() {
    
    if !notificationsAllowed {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                mealPrepNotification()
                prepareProgressionPicNotification()
                prepareFriNotification()
                prepareRelaxNotification()
                prepareMFNotification()
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
