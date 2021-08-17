//
//  PreWorkoutModels.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/25/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//

import UIKit

enum PreWorkout {
    
  // MARK: Use cases
  
  enum FetchUser {
    struct Request {
    }
    
    struct Response {
        var user: User
    }
    
    struct ViewModel {
        
        struct UserDetails {
            var name: String?
            var coreLevel: String
            var totalPoints: String
            var nextLevel: String
            var nextWorkoutDate: String
        }
        var userDetails: UserDetails
    }
  }
    
    enum FetchExercises {
        struct Request {
        }
        
        struct Response {
            var exercises: [Exercise]
        }
        
        struct ViewModel {
            
        }
    }
}
