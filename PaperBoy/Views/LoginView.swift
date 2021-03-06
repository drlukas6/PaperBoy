//
//  LoginView.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 23/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout


class LoginView: UIView {
    var shouldUpdateConstraints = true
    var fieldsStackView: UIStackView!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var loginButton: UIButton!
    var registerButton: UIButton!
    var copyrightLabel: UILabel!
    var containerView: UIView!
    var logoImage: UIImageView!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
        addSubviews()
        setupSubviews()
        animateBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
        addSubviews()
        setupSubviews()
        animateBackground()
    }

    
    private func initializeSubviews() {
        fieldsStackView = UIStackView()
        usernameTextField = UITextField()
        passwordTextField = UITextField()
        loginButton = UIButton(type: .system)
        registerButton = UIButton(type: .system)
        copyrightLabel = UILabel()
        containerView = UIView()
        logoImage = UIImageView(image: UIImage(named: ViewProperties.logo))
    }
    
    private func addSubviews() {
        self.addSubview(logoImage)
        fieldsStackView.addArrangedSubview(usernameTextField)
        fieldsStackView.addArrangedSubview(passwordTextField)
        fieldsStackView.addArrangedSubview(loginButton)
        fieldsStackView.addArrangedSubview(registerButton)
        self.addSubview(containerView)
        containerView.addSubview(fieldsStackView)
        self.addSubview(copyrightLabel)
    }
    
    private func setupSubviews() {
        self.backgroundColor = .black
        
        copyrightLabel.text = "Copyright © 2018 Lukas Sestic. All rights reserved."
        copyrightLabel.font = UIFont(name: copyrightLabel.font.fontName, size: 12)
        copyrightLabel.textColor = .lightGray
        copyrightLabel.textAlignment = .center
        copyrightLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: ViewProperties.edgeInset, left: ViewProperties.edgeInset, bottom: ViewProperties.edgeMarginInset, right: ViewProperties.edgeInset), excludingEdge: .top)
        
        usernameTextField.placeholder = "username"
        usernameTextField.font = UIFont(name: (usernameTextField.font?.fontName)!, size: 18)
        usernameTextField.textContentType = .username
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = "********"
        passwordTextField.font = UIFont(name: (passwordTextField.font?.fontName)!, size: 18)
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true


        loginButton.setTitle("Login", for: .normal)
        loginButton.autoSetDimension(.height, toSize: 40.0)
        loginButton.layer.cornerRadius = 20.0
        loginButton.backgroundColor = .neonPink
        loginButton.tintColor = .white
        loginButton.isEnabled = false
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = UIFont(name: (registerButton.titleLabel?.font.fontName)!, size: 12)
        registerButton.autoSetDimension(.height, toSize: 12)
        registerButton.tintColor = .lightGray
        
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15.0
        containerView.autoCenterInSuperview()
        containerView.autoMatch(.width, to: .width, of: self, withMultiplier: ViewProperties.threeQuarters)
        
        fieldsStackView.axis = .vertical
        fieldsStackView.distribution = .equalSpacing
        fieldsStackView.spacing = 15.0
        fieldsStackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: ViewProperties.edgeMarginInset, left: ViewProperties.edgeInset, bottom: ViewProperties.edgeMarginInset, right: ViewProperties.edgeInset))
        
        logoImage.contentMode = .scaleAspectFit
        logoImage.autoPinEdge(toSuperviewMargin: .top)
        logoImage.autoPinEdge(toSuperviewMargin: .leading)
        logoImage.autoPinEdge(toSuperviewMargin: .trailing)
        logoImage.autoMatch(.height, to: .height, of: self, withMultiplier: 0.25)
    }
    
    private func animateBackground() {
        UIView.animate(withDuration: 7.0, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            self.backgroundColor = .neonBlue
        })
    }
}

