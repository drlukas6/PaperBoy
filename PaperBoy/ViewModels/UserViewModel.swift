//
//  UserViewModel.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 23/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation

class UserViewModel {
    private let minUsernameLength = 6
    private let minPasswordLength = 8
    
    private var user = User() {
        didSet {
            username.value = user.username
            password.value = user.password
        }
    }
    var username: ObserverBox<String> = ObserverBox(observable: "")
    var password: ObserverBox<String> = ObserverBox(observable: "")
}

extension UserViewModel {
    func updateUsername(_ username: String) {
        user.username = username
    }
    
    func updatePassword(_ password: String) {
        user.password = password
    }
    
    func validateLengths(_ username: String, _ password: String) -> Bool {
        if username.count >= minUsernameLength && password.count >= minPasswordLength { return true}
        return false
    }
}
