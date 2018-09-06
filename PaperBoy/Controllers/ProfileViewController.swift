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
    private var profileViewModel: ProfileViewModel!
    
    convenience init(for currentUser: Users) {
        self.init()
        self.profileViewModel = ProfileViewModel(currentUser: currentUser)
        profileView = ProfileView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
        
        view.addSubview(profileView)
        profileView.autoPinEdgesToSuperviewEdges()
        
        setupView()
    }
    
    private func setupView() {
        let level = profileViewModel.calculateLevel()
        print(level)
        profileView.profileNameLabel.text = profileViewModel.getUsername()
        profileView.profileLvlLabel.text = "LEVEL: \(Int(level))"
        profileView.numberOfRead.text = "\(profileViewModel.getArticlesRead())"
        profileView.numberOfSaved.text = "\(profileViewModel.getArticlesSaved())"
        profileView.lvlStartLabel.text = "LVL. \(Int(level))"
        profileView.lvlNextLabel.text = "LVL. \(Int(level) + 1)"
        profileView.progressBar.setProgress(Float(level - floor(level)), animated: false)
    }
}

extension ProfileViewController: UserUpdater {
    func updateUserInfo() {
        setupView()
    }
}
