//
//  Notifications.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/8/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation
import UserNotifications

let notificationCenter = UNUserNotificationCenter.current()
func prepareNotification() {
    
    //Create user notification
    let content = UNMutableNotificationContent()
    content.title = "Meal Prepping is mandatory for Results!"
    content.body = "Its the beginning of the week. Let's get started the right way and be sure to meal prep!"
    content.sound = UNNotificationSound.default
    
    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    
    dateComponents.weekday = 1
    dateComponents.hour = 14
    
    
    // Create the trigger as a repeating event.
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents, repeats: true)
    
    let request = UNNotificationRequest(identifier: "MealPrep", content: content, trigger: trigger)
    
    notificationCenter.add(request) { (error) in
        if error != nil {
            // Handle any errors.
        }
    }
}

func prepareProgressionPicNotification() {
    
    let content = UNMutableNotificationContent()
    content.title = "FLEXX Time!"
    content.body = "Time to take your progression pic to keep yourself on track!"
    content.sound = UNNotificationSound.default
    
    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    
    dateComponents.weekday = 1
    dateComponents.hour = 20
    
    
    // Create the trigger as a repeating event.
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents, repeats: true)
    
    let request = UNNotificationRequest(identifier: "Flexx.Pic", content: content, trigger: trigger)
    
    notificationCenter.add(request) { (error) in
        if error != nil {
            // Handle any errors.
        }
    }
}
    
    func prepareWHWNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Work Hard Wednesday!"
        content.body = "Your goals don't care how you feel!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.weekday = 4
        dateComponents.hour = 19
        
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "WHW", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }
    }

func prepareMFNotification() {
    
    let content = UNMutableNotificationContent()
    content.title = "Time to Focus In!"
    content.body = "Rule #1. Never skip a Monday workout!"
    content.sound = UNNotificationSound.default
    
    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    
    dateComponents.weekday = 2
    dateComponents.hour = 8
    
    
    // Create the trigger as a repeating event.
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents, repeats: true)
    
    let request = UNNotificationRequest(identifier: "MFocus", content: content, trigger: trigger)
    
    notificationCenter.add(request) { (error) in
        if error != nil {
            // Handle any errors.
        }
    }
}

func prepareRelaxNotification() {
    
    let content = UNMutableNotificationContent()
    content.title = "How will you spend your Saturday?"
    content.body = "Go outside for a walk or run, take a yoga class, recover for next week!"
    content.sound = UNNotificationSound.default
    
    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    
    dateComponents.weekday = 7
    dateComponents.hour = 12
    
    
    // Create the trigger as a repeating event.
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents, repeats: true)
    
    let request = UNNotificationRequest(identifier: "RelaxSat", content: content, trigger: trigger)
    
    notificationCenter.add(request) { (error) in
        if error != nil {
            // Handle any errors.
        }
    }
}
    
    func prepareThurNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Hard Work beats Talent!"
        content.body = "Get it Done!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.weekday = 5
        dateComponents.hour = 19
        
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "ThurN", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }
    }
    
    func prepareFriNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Eat Clean!"
        content.body = "Don't throw out all your hardwork with junk this weekend!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.weekday = 6
        dateComponents.hour = 19
        
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "FriN", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
            }
        }
    }
