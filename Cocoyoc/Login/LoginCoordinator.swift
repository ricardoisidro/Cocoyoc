//
//  LoginCoordinator.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/14/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit

class LoginCoordinator: NSObject, Coordinator {

    var childCoordinators = [Coordinator]()
    var containerController = UIViewController()
    
    init(containerController: UIViewController) {
        self.containerController = containerController
    }
    
    func start() {
        startLogin()
    }
}

private extension LoginCoordinator {
    
    func startLogin() {
        containerController.add(LoadingViewController())
        let loginViewController = LoginViewController()
        containerController.remove()
        containerController.add(loginViewController)
    }
}
