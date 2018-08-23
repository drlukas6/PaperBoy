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
    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView = LoginView(frame: .zero)
        self.view.addSubview(loginView)
        loginView.autoPinEdgesToSuperviewEdges(with: .zero)
    }
}
