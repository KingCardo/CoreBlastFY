//
//  UserAPI.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/25/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

class UserAPI: UserInfoStoreProtocol {
    static var user: User = User()
    
    func fetchUserInfo(completion: @escaping(User?, UserInfoStoreError?) -> Void) {
        completion(UserAPI.user, nil)
       // completion(type(of: self).user, nil)
    }
}
