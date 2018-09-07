//
//  TutorialTwoViewController.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 06/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit

class TutorialTwoViewController: UIViewController {

    private var tutorialView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorialView = TutorialTwoView(frame: .zero)
        view.addSubview(tutorialView)
        tutorialView.autoPinEdgesToSuperviewSafeArea()
    }

}
