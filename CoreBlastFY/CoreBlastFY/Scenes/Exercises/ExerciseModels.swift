//
//  ExerciseModels.swift
//  CoreBlastFY
//
//  Created by Riccardo Washington on 5/19/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Exercises
{
  // MARK: Use cases
  
  enum Videos
  {
    struct Request
    {
    }
    struct Response
    {
        var exercises: [Exercise]
    }
    struct ViewModel
    {
        struct ExerciseVM {
            let name: String
            let url: URL
        }
        var exerciseViewModel: [ExerciseVM]
    }
  }
}
