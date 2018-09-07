//
//  TutorialOneView.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 06/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class TutorialOneView: UIView {
    var backgroundImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
        addSubviews()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
        addSubviews()
        setupSubviews()
    }
    
    private func initializeSubviews() {
        backgroundImageView = UIImageView(image: UIImage(named: ViewProperties.images.tutorial1))
    }
    
    private func addSubviews() {
        self.addSubview(backgroundImageView)
    }
    
    private func setupSubviews() {
        backgroundImageView.autoPinEdgesToSuperviewEdges()
    }
}
