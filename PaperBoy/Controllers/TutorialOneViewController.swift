//
//  TutorialOneViewController.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 06/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit

class TutorialOneViewController: UIViewController {

    private var tutorialView: TutorialOneView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .sunsetMiddle
        tutorialView = TutorialOneView(frame: .zero)
        view.addSubview(tutorialView)
        tutorialView.autoPinEdgesToSuperviewSafeArea()
    }


}
