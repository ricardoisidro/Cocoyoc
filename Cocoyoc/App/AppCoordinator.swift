//
//  AppCoordinator.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/14/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    private(set) var childCoordinators = [Coordinator]()
    private(set) var containerController = UIViewController()
    private let persistenceController = PersistenceController()
    
    func start() {
        persistenceController.loadUser()
        guard persistenceController.loggedUser != nil else {
            startLoginCoordinator()
            return
        }
        startCocoyocApp()
    }
}

private extension AppCoordinator {
    
    func startCocoyocApp() {
        let loadingViewController = LoadingViewController()
        containerController.add(loadingViewController)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            loadingViewController.remove()
            self.startWebCoordinator()
        }
    }
    
    func startLoginCoordinator() {
        let loginCoordinator = LoginCoordinator(containerController: containerController)
        loginCoordinator.delegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
    func startWebCoordinator() {
        let webCoordinator = WebCoordinator(navigationController: UINavigationController.makeForMainNavigation(), persistenceController: persistenceController)
        webCoordinator.start()
        show(container: webCoordinator.containerController)
        childCoordinators.append(webCoordinator)
    }
    
    func show(container: UIViewController) {
        containerController.children.forEach { $0.remove() }
        containerController.add(container)
    }
}

extension AppCoordinator: LoginCoordinatorDelegate {

    func loginCoordinatorDidFinish(_ loginCoordinator: LoginCoordinator, with mail: String, and password: String) {
        containerController.children.forEach { $0.remove() }
        childCoordinators.removeAll()
        try? persistenceController.save(UserAuthentication(email: mail, password: password))
        startCocoyocApp()
    }
}
