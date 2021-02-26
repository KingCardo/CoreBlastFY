//
//  UserAPI.swift
//  CoreBlast
//
//  Created by Riccardo Washington on 1/25/20.
//  Copyright © 2020 Riccardo Washington. All rights reserved.
//

import Foundation

class UserAPI: UserInfoStoreProtocol {
    static var user: User!        
    
    func fetchUserInfo(completion: @escaping(User?, UserInfoStoreError?) -> Void) {
        UserAPI.user = UserManager.loadUserFromFile()
        completion(UserAPI.user, nil)
    }
}
