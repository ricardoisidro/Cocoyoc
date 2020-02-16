//
//  AppCoordinator.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/14/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var containerController = UIViewController()
    
    func start() {
        startLoginCoordinator()
    }
}

private extension AppCoordinator {
    
    func startCocoyocApp() {
        let loadingViewController = LoadingViewController()
        containerController.add(loadingViewController)
    }
    
    func startLoginCoordinator() {
        let loginCoordinator = LoginCoordinator(containerController: containerController)
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
}
