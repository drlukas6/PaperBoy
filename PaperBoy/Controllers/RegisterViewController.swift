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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerView = RegisterView(frame: .zero)
        view.addSubview(registerView)
        registerView.autoPinEdgesToSuperviewEdges()
    }
    
}
