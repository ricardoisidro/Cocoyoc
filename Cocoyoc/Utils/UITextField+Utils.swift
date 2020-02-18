//
//  UITextField+Utils.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/17/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit

extension UITextField {
    
    func underlineWhenSelected() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.blue.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: frame.size.height)
        border.borderWidth = width
        border.name = "underline"
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
    func underlineWhenUnselected() {
        guard let sublayers = layer.sublayers else { return }
        for layer in sublayers {
            if layer.name == "underline" { layer.removeFromSuperlayer() }
        }
    }
}
