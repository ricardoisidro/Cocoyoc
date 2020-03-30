//
//  WebCoordinator.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/15/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit

protocol WebCoordinatorDelegate: class {
    func webCoordinatorDidFinish(_ webCoordinator: WebCoordinator)
}

class WebCoordinator: NSObject, Coordinator {

    var childCoordinators = [Coordinator]()
    var containerController: UIViewController
    private let persistenceController: PersistenceController

    weak var delegate: WebCoordinatorDelegate?

    private var navigationController: UINavigationController {
        return containerController as! UINavigationController
    }
    
    init(navigationController: UINavigationController, persistenceController: PersistenceController) {
        self.containerController = navigationController
        self.persistenceController = persistenceController
    }

    func start() {
        let webViewController = WebViewController()
        webViewController.delegate = self
        let authentication = persistenceController.loggedUser!
        webViewController.load(authentication)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(webViewController, animated: true)
    }
}

extension WebCoordinator: WebViewControllerDelegate {
    func webViewControllerDidFinish(_ webViewController: WebViewController) {
        delegate?.webCoordinatorDidFinish(self)
    }
}
