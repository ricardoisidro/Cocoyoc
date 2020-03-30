//
//  PersistenceController.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/22/20.
//  Copyright © 2020 jot. All rights reserved.
//

import Foundation

class PersistenceController {
    
    private let keychainController = KeychainController()
    private(set) var loggedUser: UserAuthentication?
    
    func save(_ credentials: UserAuthentication) throws {
        loggedUser = credentials
        keychainController.save(password: credentials)
    }
    
    func loadUser() {
        loggedUser = keychainController.loadUser()
    }
    
    func removeUser() {
        keychainController.removeUser()
    }
}
