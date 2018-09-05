//
//  RegisterView.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 25/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class RegisterView: UIView {
    var shouldUpdateConstraints = true
    var welcomeLabel: UILabel!
    var subtitleLabel: UILabel!
    var usernameTextField: UITextField!
    var passwordTextField: UITextField!
    var registerButton: UIButton!
    var containerView: UIView!
    var fieldsStackView: UIStackView!

    
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
        welcomeLabel = UILabel()
        subtitleLabel = UILabel()
        usernameTextField = UITextField()
        passwordTextField = UITextField()
        registerButton = UIButton(type: .system)
        containerView = UIView()
        fieldsStackView = UIStackView()
    }
    
    private func addSubviews() {
        self.addSubview(welcomeLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(usernameTextField)
        self.addSubview(passwordTextField)
        self.addSubview(registerButton)
        self.addSubview(containerView)
        containerView.addSubview(fieldsStackView)
        fieldsStackView.addArrangedSubview(usernameTextField)
        fieldsStackView.addArrangedSubview(passwordTextField)
        fieldsStackView.addArrangedSubview(registerButton)
    }
    
    private func setupSubviews() {
        self.backgroundColor = .black
        
        welcomeLabel.text = "Welcome To Paper Boy"
        welcomeLabel.lineBreakMode = .byWordWrapping
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textColor = .neonBlue
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 60)
        welcomeLabel.autoPinEdges(toSuperviewMarginsExcludingEdge: .bottom)
        
        subtitleLabel.text = "A Place For All Your Dailies"
        subtitleLabel.textColor = .neonBlue
        subtitleLabel.font = UIFont(name: welcomeLabel.font.fontName, size: 20)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: welcomeLabel, withOffset: ViewProperties.edgeInset)
        subtitleLabel.autoPinEdge(toSuperviewMargin: .leading)
        
        usernameTextField.placeholder = "username"
        usernameTextField.font = UIFont(name: (usernameTextField.font?.fontName)!, size: 18)
        usernameTextField.textContentType = .username
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        
        passwordTextField.placeholder = "********"
        passwordTextField.font = UIFont(name: (passwordTextField.font?.fontName)!, size: 18)
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        
        registerButton.setTitle("Complete Registration", for: .normal)
        registerButton.autoSetDimension(.height, toSize: 40.0)
        registerButton.layer.cornerRadius = 20.0
        registerButton.backgroundColor = .neonBlue
        registerButton.tintColor = .white
        registerButton.isEnabled = false
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 15.0
        containerView.autoCenterInSuperview()
        containerView.autoMatch(.width, to: .width, of: self, withMultiplier: ViewProperties.threeQuarters)
        
        fieldsStackView.axis = .vertical
        fieldsStackView.distribution = .equalSpacing
        fieldsStackView.spacing = 15.0
        fieldsStackView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: ViewProperties.edgeMarginInset, left: ViewProperties.edgeInset, bottom: ViewProperties.edgeMarginInset, right: ViewProperties.edgeInset))
    }
    
    private func animateBackground() {
        UIView.animate(withDuration: 7.0, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            self.backgroundColor = .neonPink
        })
    }
}
