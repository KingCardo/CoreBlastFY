//
//  SettingsModels.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 2/8/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Settings {
  // MARK: Use cases
  
  enum Items {
    struct Request {
    }
    struct Response {
         enum SettingsItem: String {
                  case about = "About FYF"
                  case thirtyDayChallenge  = "30 Day Challenge 💪"
                  case programOverview = "Program Overview"
                  case exercises = "Exercises"
                  case notifications = "Notifications"
                  case review = "Leave a 5 star review!"
                  case donation = "Want to buy me a coffee? :)"
                  case customWorkout = "Custom Workout"
                  case foodLog = "Journal"
                  case parks = "Nearby Parks"
                  case extras = "Extras"
                  case inAppPurchase = "Restore In-App Purchase"
                  case reportAProblem = "Report a Problem"
                  case termsOfUse = "Terms of Use"
              }
        var items: [SettingsItem] = [
        //.about,
        .thirtyDayChallenge,
        .programOverview,
        .exercises,
        //.customWorkout,
        .notifications,
        .review,
       // .donation,
        .foodLog,
        .reportAProblem,
        .inAppPurchase,
       // .termsOfUse,
        ]
    }
    struct ViewModel {
        struct DisplayItem {
            var title: String
        }
    }
  }
}
