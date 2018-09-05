//
//  SavedView.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 04/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class SavedView: UIView {
    var backgroundImage: UIImageView!
    var savedTableView: UITableView!
    var noArticlesLabel: UILabel!

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
        backgroundImage = UIImageView(image: UIImage(named: ViewProperties.images.background))
        savedTableView = UITableView()
        noArticlesLabel = UILabel()
    }
    
    private func addSubviews() {
        self.addSubview(backgroundImage)
        self.addSubview(noArticlesLabel)
        self.addSubview(savedTableView)
    }
    
    private func setupSubviews() {
        backgroundImage.autoPinEdgesToSuperviewEdges()
        
        noArticlesLabel.text = "No saved articles!\nSwipe left on a headline\nto save one!".uppercased()
        noArticlesLabel.textColor = .seaBlue
        noArticlesLabel.autoPinEdge(.top, to: .top, of: self, withOffset: ViewProperties.edgeMarginInset * 4)
        noArticlesLabel.autoAlignAxis(.vertical, toSameAxisOf: self)
        noArticlesLabel.numberOfLines = 0
        noArticlesLabel.textAlignment = .center
        noArticlesLabel.lineBreakMode = .byWordWrapping

        
        savedTableView.backgroundColor = .clear
        savedTableView.autoPinEdge(toSuperviewSafeArea: .top)
        savedTableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), excludingEdge: .top)
        savedTableView.separatorStyle = .none
    }
}
