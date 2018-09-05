//
//  ProfileViewController.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 04/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    private var profileView: ProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
        
        profileView = ProfileView(frame: .zero)
        view.addSubview(profileView)
        profileView.autoPinEdgesToSuperviewEdges()
    }

}
