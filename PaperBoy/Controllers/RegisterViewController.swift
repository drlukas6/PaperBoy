//
//  RegisterViewController.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 26/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit
import PureLayout

class RegisterViewController: UIViewController {

    private var registerView: RegisterView!
    private var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        registerView = RegisterView(frame: .zero)
        view.addSubview(registerView)
        registerView.autoPinEdgesToSuperviewEdges()
        
        setupDelegates()
        setupBinding()
        setupActions()
    }
    
    private func setupDelegates() {
        registerView.usernameTextField.delegate = self
        registerView.passwordTextField.delegate = self
    }
    
    private func setupBinding() {
        userViewModel.username.bind {
            if self.userViewModel.validateLengths($0, self.userViewModel.password.value) {
                self.registerView.registerButton.isEnabled = true
            }
            else {
                self.registerView.registerButton.isEnabled = false
            }
        }
        
        userViewModel.password.bind {
            if self.userViewModel.validateLengths(self.userViewModel.username.value, $0) {
                self.registerView.registerButton.isEnabled = true
            }
            else {
                self.registerView.registerButton.isEnabled = false
            }
        }
    }
    
    private func setupActions() {
        registerView.registerButton.addTarget(self, action: #selector(completeRegistration), for: .touchUpInside)
    }
    
    @objc
    private func completeRegistration() {
        if userViewModel.saveUser() {
            navigationController?.popViewController(animated: true)
        }
        else {
            registerView.registerButton.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        if textField == registerView.usernameTextField {
            userViewModel.updateUsername(newString)
        }
        else if textField == registerView.passwordTextField {
            userViewModel.updatePassword(newString)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == registerView.usernameTextField {
            registerView.passwordTextField.becomeFirstResponder()
        }
        else {
            completeRegistration()
        }
        return true
    }
}
