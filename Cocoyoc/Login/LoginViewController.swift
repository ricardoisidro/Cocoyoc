//
//  LoginViewController.swift
//  Cocoyoc
//
//  Created by Ricardo Isidro on 2/14/20.
//  Copyright © 2020 jot. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func loginViewControllerDidTapButton(_ loginViewController: LoginViewController, _ email: String, _ password: String)
}

class LoginViewController: UIViewController {

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var failLabel: UILabel!
    
    weak var delegate: LoginViewControllerDelegate?
    private var loginManager = LoginManager()
    var labelHidden: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let hidden = labelHidden else { return }
        failLabel.isHidden = hidden
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func buttonDidTouchUpinside(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        if loginManager.validate(username, password) {
            delegate?.loginViewControllerDidTapButton(self, username, password)
        } else {
            showErrorAlert()
        }
    }
}

private extension LoginViewController {
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Ingresar datos", message: "Escribe usuario y contraseña", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.underlineWhenSelected()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlineWhenUnselected()
    }
}
