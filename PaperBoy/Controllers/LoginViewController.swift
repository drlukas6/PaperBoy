//
//  LoginViewController.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 23/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit
import PureLayout
import TrapperKeeper

class LoginViewController: UIViewController {
    
    private var loginView: LoginView!
    private var userViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView(frame: .zero)
        view.addSubview(loginView)
        loginView.autoPinEdgesToSuperviewEdges()
        setupDelegates()
        setupBinding()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupDelegates() {
        loginView.usernameTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    private func setupBinding() {
        userViewModel.username.bind {
            if self.userViewModel.validateLengths($0, self.userViewModel.password.value) {
                self.loginView.loginButton.isEnabled = true
            }
            else {
                self.loginView.loginButton.isEnabled = false
            }
        }
        
        userViewModel.password.bind {
            if self.userViewModel.validateLengths(self.userViewModel.username.value, $0) {
                self.loginView.loginButton.isEnabled = true
            }
            else {
                self.loginView.loginButton.isEnabled = false
            }
        }
    }
    
    private func setupNavigation() {
        loginView.registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
    }
    
    @objc
    private func registerUser() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        if textField == loginView.usernameTextField {
            userViewModel.updateUsername(newString)
        }
        else if textField == loginView.passwordTextField {
            userViewModel.updatePassword(newString)
        }
        return true
    }
}
