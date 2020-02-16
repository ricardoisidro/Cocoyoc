//
//  LoginViewController.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/14/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func loginViewControllerDidTapButton(_ loginViewController: LoginViewController)
}

class LoginViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonDidTouchUpinside(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        if username == "user" && password == "pass" {
            print("Logged in")
            delegate?.loginViewControllerDidTapButton(self)
        }
        
    }
}
