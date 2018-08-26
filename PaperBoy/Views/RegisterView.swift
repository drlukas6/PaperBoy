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
    }
    
    private func addSubviews() {
        self.addSubview(welcomeLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(usernameTextField)
        self.addSubview(passwordTextField)
        self.addSubview(registerButton)
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
    }
    
    private func animateBackground() {
        UIView.animate(withDuration: 7.0, delay: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            self.backgroundColor = .neonPink
        })
    }
}
