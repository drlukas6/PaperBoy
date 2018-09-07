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
        setupActions()
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
    
    private func setupActions() {
        loginView.registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
    }
    
    @objc
    private func registerUser() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc
    private func loginUser() {
        let usernamePredicate = NSPredicate(format: "username = %@", userViewModel.username.value)
        if let user = PersistenceService.getDataFromEntity(from: CoreDataPropertyKeys.usersEntity, with: usernamePredicate)?.first as? Users, let password = user.password, let enteredPassword = userViewModel.password.value.sha256Data(), password == enteredPassword {
                print("Login successfull")
                createTabBarController(for: user)
        }
        else {
            loginView.loginButton.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
        }
    }
    
    private func createTabBarController(for user: Users) {
        guard let username = user.username else { return }
        
        UserDefaults.standard.set(username, forKey: UserDefaultsPropertyKeys.username)
        
        switch user.isNew {
        case true:
            displayTutorial(for: user)
        case false:
            dispayHeadlines(for: user)
        }
    }
    
    private func displayTutorial(for currentUser: Users) {

        let mainTutorialVC = MainTutorialUViewController(currentUser: currentUser)
        self.present(mainTutorialVC, animated: true, completion: nil)
    }
    
    private func dispayHeadlines(for user: Users) {
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.barStyle = .black
        tabBarVC.tabBar.tintColor = .neonPink
        
        let profileVC = ProfileViewController(for: user)
        profileVC.tabBarItem.image = UIImage(named: ViewProperties.images.profile)
        profileVC.tabBarItem.title = "Profile"
        
        let savedVC = SavedViewController(dataSource: SavedArticlesDataSource(), currentUser: user)
        savedVC.tabBarItem.image = UIImage(named: ViewProperties.images.saved)
        savedVC.tabBarItem.title = "Saved"
        
        let headlinesVC = HeadlinesViewController(dataSource: ArticlesDataSource(), currentUser: user, viewControllersToUpdate: [profileVC, savedVC])
        headlinesVC.tabBarItem.image = UIImage(named: ViewProperties.images.headlines)
        headlinesVC.tabBarItem.title = "Headlines"
        
        tabBarVC.setViewControllers([headlinesVC, savedVC, profileVC], animated: true)
        self.present(tabBarVC, animated: true, completion: nil)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.usernameTextField {
            loginView.passwordTextField.becomeFirstResponder()
        }
        else {
            loginUser()
            resignFirstResponder()
        }
        return true
    }
}
