//
//  PreWorkoutWorker.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/25/20.
//  Copyright (c) 2020 Riccardo Washington. All rights reserved.
//

import Foundation

protocol UserInfoStoreProtocol {
    func fetchUserInfo(completion: @escaping(User?, UserInfoStoreError?) -> Void)
}

class PreWorkoutWorker {
    
    var userInfoStore: UserInfoStoreProtocol

    init(userInfoStore: UserInfoStoreProtocol) {
        self.userInfoStore = userInfoStore
    }
    
    func fetchUserInfo(completion: @escaping(User?, Error?) -> Void) {
        userInfoStore.fetchUserInfo { (user, error) in
            if let user = user {
            completion(user, nil)
            } else if let error = error {
                completion(nil, UserInfoStoreError.CannotFetch(error.localizedDescription))
            }
        }
  }
}

enum UserInfoStoreResult<U> {
    case Success(result: U)
    case Failure(error: UserInfoStoreError)
}

enum UserInfoStoreError: Equatable, Error {
    case CannotFetch(String)
}

func ==(lhs: UserInfoStoreError, rhs: UserInfoStoreError) -> Bool
{
  switch (lhs, rhs) {
  case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
    default: return false
    }
    
}
