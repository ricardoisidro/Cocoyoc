//
//  WebCoordinator.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/15/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit

class WebCoordinator: NSObject, Coordinator {

    var childCoordinators = [Coordinator]()
    var containerController: UIViewController
    private var navigationController: UINavigationController {
        return containerController as! UINavigationController
    }
    
    init(navigationController: UINavigationController) {
        self.containerController = navigationController
    }

    func start() {
        let webViewController = WebViewController()
        navigationController.pushViewController(webViewController, animated: true)
    }
}
