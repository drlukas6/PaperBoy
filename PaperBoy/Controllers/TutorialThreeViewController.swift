//
//  TutorialThreeViewController.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 06/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit

class TutorialThreeViewController: UIViewController {

    private var tutorialView: TutorialThreeView!
    private var currentUser: Users!
    private var isCompleted: Bool = false
    
    convenience init(currentUser: Users) {
        self.init()
        self.currentUser = currentUser
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorialView = TutorialThreeView(frame: .zero)
        view.addSubview(tutorialView)
        tutorialView.autoPinEdgesToSuperviewSafeArea()
        
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isCompleted {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    private func setupActions() {
        tutorialView.completeTutorialButton.addTarget(self, action: #selector(completeTutorial), for: .touchUpInside)
    }
    
    @objc
    private func completeTutorial() {
        isCompleted = true
        
        currentUser.isNew = false
        PersistenceService.saveContext()
        
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.barStyle = .black
        tabBarVC.tabBar.tintColor = .neonPink
        
        let profileVC = ProfileViewController(for: currentUser)
        profileVC.tabBarItem.image = UIImage(named: ViewProperties.images.profile)
        profileVC.tabBarItem.title = "Profile"
        
        let savedVC = SavedViewController(dataSource: SavedArticlesDataSource(), currentUser: currentUser)
        savedVC.tabBarItem.image = UIImage(named: ViewProperties.images.saved)
        savedVC.tabBarItem.title = "Saved"
        
        let headlinesVC = HeadlinesViewController(dataSource: ArticlesDataSource(), currentUser: currentUser, viewControllersToUpdate: [profileVC, savedVC])
        headlinesVC.tabBarItem.image = UIImage(named: ViewProperties.images.headlines)
        headlinesVC.tabBarItem.title = "Headlines"
        
        tabBarVC.setViewControllers([headlinesVC, savedVC, profileVC], animated: true)
        self.present(tabBarVC, animated: true, completion: nil)
    }

}
