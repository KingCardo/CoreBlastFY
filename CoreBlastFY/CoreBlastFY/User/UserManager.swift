//
//  UserManager.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 12/14/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import Foundation

func isPassedMoreThan(days: Int, fromDate date : Date, toDate date2 : Date) -> Bool {
    let unitFlags: Set<Calendar.Component> = [.day]
    let deltaD = Calendar.current.dateComponents( unitFlags, from: date, to: date2)
    return deltaD.day! > days
}


class UserManager {
    
    static func decrementPoint() -> Bool {
        let today = Date()
        guard let lastWorkout = UserAPI.user.lastWorkoutComplete else { return false }
        if isPassedMoreThan(days: 2, fromDate: lastWorkout, toDate: today) {
            if UserAPI.user.totalPoints > 0 {
            UserAPI.user.totalPoints -= 1
            }
        save()
            return true
        } else {
            return false
        }
    }
    
    static func incrementPoint() {
        UserAPI.user.lastWorkoutComplete = Date()
        UserAPI.user.totalPoints += 1
        save()
    }
    
    static func calculateLevel(totalPoints: Int) {
        switch totalPoints {
        case _ where totalPoints == UserAPI.user.nextLevelUp:
            UserAPI.user.coreLevel = UserAPI.user.nextLevel
            save()
        default: break
        }
    }
    
    static func save() {
        
             let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
             let archiveURL = documentsDirectory.appendingPathComponent("User").appendingPathExtension("json")
             
             let jsonEncoder = JSONEncoder()
             
             do {
                let encodedData = try jsonEncoder.encode(UserAPI.user)
                 try encodedData.write(to: archiveURL)
             } catch let error {
                 print(error)
             }
             
         }
         
    static func loadUserFromFile() -> User {
            
             let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
             let archiveURL = documentsDirectory.appendingPathComponent("User").appendingPathExtension("json")
             
             let jsonDecoder = JSONDecoder()
            guard let decodedData = try? Data(contentsOf: archiveURL) else { return User() }
            
             do {
                let user = try jsonDecoder.decode(User.self, from: decodedData)
                return user
             } catch let error {
                 print(error)
                return User()
             }
         }
    }
