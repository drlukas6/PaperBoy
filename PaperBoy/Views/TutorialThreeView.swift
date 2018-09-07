//
//  TutorialThreeView.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 06/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class TutorialThreeView: UIView {
    var backgroundImageView: UIImageView!
    var completeTutorialButton: UIButton!
    
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
        backgroundImageView = UIImageView(image: UIImage(named: ViewProperties.images.tutorial3))
        completeTutorialButton = UIButton(type: .system)
    }
    
    private func addSubviews() {
        self.addSubview(backgroundImageView)
        self.addSubview(completeTutorialButton)
    }
    
    private func setupSubviews() {
        backgroundImageView.autoPinEdgesToSuperviewEdges()
        
        completeTutorialButton.autoPinEdgesToSuperviewSafeArea(with: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), excludingEdge: .top)
        completeTutorialButton.autoSetDimension(.height, toSize: 40.0)
        completeTutorialButton.backgroundColor = .sunsetStart
        completeTutorialButton.tintColor = .sunsetEnd
        completeTutorialButton.setTitle("BEAM ME UP!", for: .normal)
    }
}
