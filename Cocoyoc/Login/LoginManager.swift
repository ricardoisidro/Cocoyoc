//
//  LoginManager.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 3/7/20.
//  Copyright © 2020 jot. All rights reserved.
//

import Foundation

struct UserAuthentication: Codable {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

class LoginManager {
    
    func validate(_ email: String, _ password: String) -> Bool {
        return email != "" && password != ""
    }
}
