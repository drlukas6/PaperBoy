//
//  HighlightsView.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 27/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class HeadlinesView: UIView {
    var backgroundImage: UIImageView!
    var headlinesTableView: UITableView!
    var slider: UIScrollView!
    var categories: UIStackView!
    var general: UIButton!
    var health: UIButton!
    var business: UIButton!
    var entertainment: UIButton!
    var science: UIButton!
    var sports: UIButton!
    var technology: UIButton!
    
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
        headlinesTableView = UITableView()
        slider = UIScrollView()
        categories = UIStackView()
        general = UIButton(type: .system)
        health = UIButton(type: .system)
        business = UIButton(type: .system)
        entertainment = UIButton(type: .system)
        science = UIButton(type: .system)
        sports = UIButton(type: .system)
        technology = UIButton(type: .system)
    }
    
    private func addSubviews() {
        self.addSubview(backgroundImage)
        self.addSubview(slider)
        slider.addSubview(categories)
        categories.addArrangedSubview(general)
        categories.addArrangedSubview(health)
        categories.addArrangedSubview(business)
        categories.addArrangedSubview(entertainment)
        categories.addArrangedSubview(science)
        categories.addArrangedSubview(sports)
        categories.addArrangedSubview(technology)
        self.addSubview(headlinesTableView)
    }
    
    private func setupSubviews() {
        backgroundImage.autoPinEdgesToSuperviewEdges()
        
        slider.autoPinEdge(toSuperviewSafeArea: .top)
        slider.autoPinEdge(toSuperviewEdge: .leading)
        slider.autoPinEdge(toSuperviewEdge: .trailing)
        slider.autoSetDimension(.height, toSize: 40.0)

        categories.autoPinEdgesToSuperviewEdges()
        categories.axis = .horizontal
        categories.distribution = .equalSpacing
        categories.spacing = 5.0
        
        general.setTitle(NewsApiPropertyKeys.categories.general.uppercased(), for: .normal)
        general.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0)
        general.titleLabel?.lineBreakMode = .byWordWrapping
        general.titleLabel?.adjustsFontSizeToFitWidth = true
        general.titleLabel?.numberOfLines = 1
        general.tintColor = .neonPink
        general.layer.cornerRadius = 5.0
        general.layer.borderWidth = 2.0
        general.layer.borderColor = UIColor.neonPink.cgColor
        
        health.setTitle(NewsApiPropertyKeys.categories.health.uppercased(), for: .normal)
        health.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0)
        health.titleLabel?.lineBreakMode = .byWordWrapping
        health.titleLabel?.adjustsFontSizeToFitWidth = true
        health.titleLabel?.numberOfLines = 1
        health.tintColor = .neonPink
        health.layer.cornerRadius = 5.0
        health.layer.borderWidth = 2.0
        health.layer.borderColor = UIColor.neonPink.cgColor
        
        business.setTitle(NewsApiPropertyKeys.categories.business.uppercased(), for: .normal)
        business.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0)
        business.titleLabel?.lineBreakMode = .byWordWrapping
        business.titleLabel?.adjustsFontSizeToFitWidth = true
        business.titleLabel?.numberOfLines = 1
        business.tintColor = .neonPink
        business.layer.cornerRadius = 5.0
        business.layer.borderWidth = 2.0
        business.layer.borderColor = UIColor.neonPink.cgColor
        
        entertainment.setTitle(NewsApiPropertyKeys.categories.entertainment.uppercased(), for: .normal)
        entertainment.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0)
        entertainment.titleLabel?.lineBreakMode = .byWordWrapping
        entertainment.titleLabel?.adjustsFontSizeToFitWidth = true
        entertainment.titleLabel?.numberOfLines = 1
        entertainment.tintColor = .neonPink
        entertainment.layer.cornerRadius = 5.0
        entertainment.layer.borderWidth = 2.0
        entertainment.layer.borderColor = UIColor.neonPink.cgColor
        
        science.setTitle(NewsApiPropertyKeys.categories.science.uppercased(), for: .normal)
        science.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0)
        science.titleLabel?.lineBreakMode = .byWordWrapping
        science.titleLabel?.adjustsFontSizeToFitWidth = true
        science.titleLabel?.numberOfLines = 1
        science.tintColor = .neonPink
        science.layer.cornerRadius = 5.0
        science.layer.borderWidth = 2.0
        science.layer.borderColor = UIColor.neonPink.cgColor
        
        sports.setTitle(NewsApiPropertyKeys.categories.sports.uppercased(), for: .normal)
        sports.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0)
        sports.titleLabel?.lineBreakMode = .byWordWrapping
        sports.titleLabel?.adjustsFontSizeToFitWidth = true
        sports.titleLabel?.numberOfLines = 1
        sports.tintColor = .neonPink
        sports.layer.cornerRadius = 5.0
        sports.layer.borderWidth = 2.0
        sports.layer.borderColor = UIColor.neonPink.cgColor
        
        technology.setTitle(NewsApiPropertyKeys.categories.technology.uppercased(), for: .normal)
        technology.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0)
        technology.titleLabel?.lineBreakMode = .byWordWrapping
        technology.titleLabel?.adjustsFontSizeToFitWidth = true
        technology.titleLabel?.numberOfLines = 1
        technology.tintColor = .neonPink
        technology.layer.cornerRadius = 5.0
        technology.layer.borderWidth = 2.0
        technology.layer.borderColor = UIColor.neonPink.cgColor
        
        headlinesTableView.backgroundColor = .clear
        headlinesTableView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0), excludingEdge: .top)
        headlinesTableView.autoPinEdge(.top, to: .bottom, of: slider)
        headlinesTableView.separatorStyle = .none
    }
}
