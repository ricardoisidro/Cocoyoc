//
//  UINavigationController+Utils.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/15/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    static func makeForMainNavigation() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        return navigationController
    }
}
