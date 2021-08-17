//
//  PreWorkoutPresenter.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/25/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//

import UIKit

protocol PreWorkoutPresentationLogic {
  func presentUser(response: PreWorkout.FetchUser.Response)
}

class PreWorkoutPresenter: PreWorkoutPresentationLogic {
  weak var viewController: PreWorkoutDisplayLogic?
    
let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "en_US_POSIX")
      dateFormatter.dateFormat = "HH:mm"
      dateFormatter.timeStyle = .short
      return dateFormatter
    }()
    
  // MARK: Do something
  
  func presentUser(response: PreWorkout.FetchUser.Response) {
    
    let user = response.user
    let userDate = UserDefaults.standard.object(forKey: UserManager.workoutDateKey) as? Date
    let totalPoints = UserDefaults.standard.integer(forKey: UserManager.totalPointsKey)
    
    let displayedUserInfo = PreWorkout.FetchUser.ViewModel.UserDetails(name: user.name, coreLevel: user.currentLevel.rawValue, totalPoints: "\(totalPoints)", nextLevel: "\(user.nextLevelUp)", nextWorkoutDate: dateFormatter.string(from: userDate ?? user.nextWorkout))
    let viewModel = PreWorkout.FetchUser.ViewModel(userDetails: displayedUserInfo)
    viewController?.displayPreWorkoutViewModel(viewModel: viewModel)
  }
}
