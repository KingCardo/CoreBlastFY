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

let refreshId = "com.Franchiz.CoreBlast.refresh"

func getHourAndMinuteFromDate(date: Date) -> (hour: Int?, minute: Int?) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm"
    let calendar = Calendar.current
    let comp = calendar.dateComponents([.hour, .minute], from: date)
    let hour = comp.hour
    let minute = comp.minute
    return (hour, minute)
}

func workoutsFailedNotification() {
    let content = UNMutableNotificationContent()
       content.title = "Downloading Program Failed!"
       content.body = "Come back to Redownload!"
       content.sound = UNNotificationSound.default
       
       // Create the trigger as a repeating event.
       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
       
        let request = UNNotificationRequest(identifier: "WorkoutsFailed", content: content, trigger: trigger)
       
       notificationCenter.add(request) { (error) in
           if error != nil {
               // Handle any errors.
           }
       }
    
}

func workoutsReadyNotification() {
    let content = UNMutableNotificationContent()
       content.title = "Workout Section Ready💎!"
       content.body = "Time To Get to Work!"
       content.sound = UNNotificationSound.default
       
       // Create the trigger as a repeating event.
       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
       
        let request = UNNotificationRequest(identifier: "WorkoutsReady", content: content, trigger: trigger)
       
       notificationCenter.add(request) { (error) in
           if error != nil {
               // Handle any errors.
           }
       }
    
}
let mondayTitle = "Time to get a workout in! 💪"
let mondayBody = "Your goals don't care how you feel!"
func timeToWorkoutMNotification() {
    //Create user notification
       let content = UNMutableNotificationContent()
       content.title = mondayTitle
       content.body = mondayBody
       content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: Sounds.timeForWorkout))
       
       var dateComponents = DateComponents()
       dateComponents.calendar = Calendar.current
    dateComponents.timeZone = TimeZone.current
       
       dateComponents.weekday = 2
       dateComponents.hour = UserAPI.user.selectedHour
       dateComponents.minute = UserAPI.user.selectedMinute
       // Create the trigger as a repeating event.
       let trigger = UNCalendarNotificationTrigger(
           dateMatching: dateComponents, repeats: true)
       
    let request = UNNotificationRequest(identifier: NotificationIDs.mondayID, content: content, trigger: trigger)
       
       notificationCenter.add(request) { (error) in
           if error != nil {
               // Handle any errors.
           }
       }
}

let tuesdayTitle = "Trust the process"
let tuesdayBody = "Time to get a workout in 💪"

func timeToWorkoutTNotification() {
    //Create user notification
       let content = UNMutableNotificationContent()
       content.title = tuesdayTitle
       content.body = tuesdayBody
       content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: Sounds.timeForWorkout))
       
       var dateComponents = DateComponents()
       dateComponents.calendar = Calendar.current
    dateComponents.timeZone = TimeZone.current
       
       dateComponents.weekday = 3
       dateComponents.hour = UserAPI.user.selectedHour
       dateComponents.minute = UserAPI.user.selectedMinute
       // Create the trigger as a repeating event.
       let trigger = UNCalendarNotificationTrigger(
           dateMatching: dateComponents, repeats: true)
       
    let request = UNNotificationRequest(identifier: NotificationIDs.tuesdayID, content: content, trigger: trigger)
       
       notificationCenter.add(request) { (error) in
           if error != nil {
               // Handle any errors.
           }
       }
}

let wednesdayTitle = "Time to get a workout in!"
let wednesdayBody = "Consistency is key 🔑"

func timeToWorkoutWNotification() {
    //Create user notification
       let content = UNMutableNotificationContent()
       content.title = wednesdayTitle
       content.body = wednesdayBody
       content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: Sounds.timeForWorkout))
       
       var dateComponents = DateComponents()
       dateComponents.calendar = Calendar.current
    dateComponents.timeZone = TimeZone.current
       
       dateComponents.weekday = 4
       dateComponents.hour = UserAPI.user.selectedHour
       dateComponents.minute = UserAPI.user.selectedMinute
       // Create the trigger as a repeating event.
       let trigger = UNCalendarNotificationTrigger(
           dateMatching: dateComponents, repeats: true)
       
    let request = UNNotificationRequest(identifier: NotificationIDs.wednesdayID, content: content, trigger: trigger)
       
       notificationCenter.add(request) { (error) in
           if error != nil {
               // Handle any errors.
           }
       }
}

let thursdayTitle = "Time to get a workout in!"
let thursdayBody = "You want results or regret?"

func timeToWorkoutTHNotification() {
    //Create user notification
       let content = UNMutableNotificationContent()
       content.title = thursdayTitle
       content.body = thursdayBody
       content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: Sounds.timeForWorkout))
       
       var dateComponents = DateComponents()
       dateComponents.calendar = Calendar.current
       dateComponents.timeZone = TimeZone.current
       
       dateComponents.weekday = 5
       dateComponents.hour = UserAPI.user.selectedHour
       dateComponents.minute = UserAPI.user.selectedMinute
       // Create the trigger as a repeating event.
       let trigger = UNCalendarNotificationTrigger(
           dateMatching: dateComponents, repeats: true)
       
    let request = UNNotificationRequest(identifier: NotificationIDs.thursdayID, content: content, trigger: trigger)
       
       notificationCenter.add(request) { (error) in
           if error != nil {
               // Handle any errors.
           }
       }
}

let fridayTitle = "Time to get a workout in!"
let fridayBody = "Everyday is a new chance to get better 💎"

func timeToWorkoutFNotification() {
    //Create user notification
       let content = UNMutableNotificationContent()
       content.title = fridayTitle
       content.body = fridayBody
       content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: Sounds.timeForWorkout))
       
       var dateComponents = DateComponents()
       dateComponents.calendar = Calendar.current
       dateComponents.timeZone = TimeZone.current
       
       dateComponents.weekday = 6
       dateComponents.hour = UserAPI.user.selectedHour
       dateComponents.minute = UserAPI.user.selectedMinute
       // Create the trigger as a repeating event.
       let trigger = UNCalendarNotificationTrigger(
           dateMatching: dateComponents, repeats: true)
       
    let request = UNNotificationRequest(identifier: NotificationIDs.fridayID, content: content, trigger: trigger)
       
       notificationCenter.add(request) { (error) in
           if error != nil {
               // Handle any errors.
           }
       }
}

func mealPrepNotification() {
    
    //Create user notification
    let content = UNMutableNotificationContent()
    content.title = "Meal Prepping is mandatory for Results!"
    content.body = "Its the beginning of the week. Let's get started the right way and be sure to meal prep!"
    content.sound = UNNotificationSound.default
    
    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    dateComponents.timeZone = TimeZone.current
    
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
    dateComponents.timeZone = TimeZone.current
    
    dateComponents.weekday = 7
    dateComponents.hour = 12
    
    
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

func prepareMFNotification() {

    let content = UNMutableNotificationContent()
    content.title = "Time to Focus In!"
    content.body = "Rule #1. Never skip a Monday workout!"
    content.sound = UNNotificationSound.default

    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    dateComponents.timeZone = TimeZone.current

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
//
func prepareRelaxNotification() {

    let content = UNMutableNotificationContent()
    content.title = "How will you spend your Saturday?"
    content.body = "Go outside for a walk or run, take a yoga class, recover for next week!"
    content.sound = UNNotificationSound.default

    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    dateComponents.timeZone = TimeZone.current

    dateComponents.weekday = 7
    dateComponents.hour = 9


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

    func prepareFriNotification() {

        let content = UNMutableNotificationContent()
        content.title = "Eat Clean!"
        content.body = "Don't throw out all your hardwork with junk this weekend!"
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.timeZone = TimeZone.current

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

func prepareJournalEntryNotification() {

    let content = UNMutableNotificationContent()
    content.title = "Entry time!"
    content.body = "Time to enter today's meals and how your feeling!"
    content.sound = UNNotificationSound.default

    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    dateComponents.timeZone = TimeZone.current

    dateComponents.hour = 20
    
    // Create the trigger as a repeating event.
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents, repeats: true)

    let request = UNNotificationRequest(identifier: "JournalEntry", content: content, trigger: trigger)

    notificationCenter.add(request) { (error) in
        if error != nil {
            // Handle any errors.
        }
    }
}

struct Sounds {
    static let timeForWorkout = "workoutTime.wav"
    static let dontBeLazy = "cantbelazy.m4a"
    static let backOnTrack = "backontrack.m4a"
}

struct NotificationIDs {
    
    static let mondayID = "mondayID"
    static let tuesdayID = "tuesdayID"
    static let wednesdayID = "wednesdayID"
    static let thursdayID = "thursdayID"
    static let fridayID = "fridayID"
    static let allIDs = [mondayID, tuesdayID, wednesdayID, thursdayID, fridayID]
    
    static func prepareNotification(id: String, weekday: Int, hour: Int, minute: Int, title: String = "Time to get a workout in!", body: String = "You want results or regret?") {
        let content = UNMutableNotificationContent()
               content.title = title
               content.body = body
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: Sounds.timeForWorkout))
               
               var dateComponents = DateComponents()
               dateComponents.calendar = Calendar.current
               dateComponents.timeZone = TimeZone.current
               
               dateComponents.weekday = weekday
               dateComponents.hour = hour
               dateComponents.minute = minute
               
               
               // Create the trigger as a repeating event.
               let trigger = UNCalendarNotificationTrigger(
                   dateMatching: dateComponents, repeats: true)
               
               let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
               
               notificationCenter.add(request) { (error) in
                   if error != nil {
                       // TO DO - Handle any errors.
                   }
               }
    }
    
    static func removeNotification(ids: [String]) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ids)
    }
    
}
