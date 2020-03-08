//
//  LoginCoordinator.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/14/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit

protocol LoginCoordinatorDelegate: class {
    func loginCoordinatorDidFinish(_ loginCoordinator: LoginCoordinator, with mail: String, and password: String)
}

class LoginCoordinator: NSObject, Coordinator {

    var childCoordinators = [Coordinator]()
    var containerController: UIViewController
    
    weak var delegate: LoginCoordinatorDelegate?
    
    init(containerController: UIViewController) {
        self.containerController = containerController
    }
    
    func start() {
        startLogin()
    }
}

private extension LoginCoordinator {
    
    func startLogin() {
        let loginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loginViewController.view.frame = containerController.view.frame
        loginViewController.delegate = self
        containerController.add(loginViewController)
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func loginViewControllerDidTapButton(_ loginViewController: LoginViewController, _ email: String, _ password: String) {
        delegate?.loginCoordinatorDidFinish(self, with: email, and: password)
    }
}
