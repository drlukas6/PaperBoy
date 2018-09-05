//
//  ProfileView.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 04/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class ProfileView: UIView {
    private struct ProfileProperties {
        static let imageSize: CGFloat = 100.0
        static let profileInset: CGFloat = 36.0
        static let sunsetEnd: UIColor = UIColor(red:0.32, green:0.12, blue:0.40, alpha:1.0)
        static let sunsetMiddle: UIColor = UIColor(red:0.74, green:0.07, blue:0.39, alpha:1.0)
        static let sunsetStart: UIColor = UIColor(red:0.90, green:0.62, blue:0.38, alpha:1.0)
    }
    
    var backgroundImage: UIImageView!
    var progressContainer: UIView!
    var happyImage: UIImageView!
    var profileNameLabel: UILabel!
    var profileLvlLabel: UILabel!
    var lvlStartLabel: UILabel!
    var lvlNextLabel: UILabel!
    var progressBar: UIProgressView!
    var articlesRead: UILabel!
    var numberOfRead: UILabel!
    var articlesSaved: UILabel!
    var numberOfSaved: UILabel!
    var logoutButton: UIButton!
    
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
        progressContainer = UIView()
        happyImage = UIImageView(image: UIImage(named: ViewProperties.images.happy))
        profileNameLabel = UILabel()
        profileLvlLabel = UILabel()
        lvlStartLabel = UILabel()
        lvlNextLabel = UILabel()
        articlesRead = UILabel()
        numberOfRead = UILabel()
        articlesSaved = UILabel()
        numberOfSaved = UILabel()
        logoutButton = UIButton(type: .system)
        progressBar = UIProgressView(progressViewStyle: .default)
    }
    
    private func addSubviews() {
        self.addSubview(backgroundImage)
        self.addSubview(progressContainer)
        progressContainer.addSubview(lvlStartLabel)
        progressContainer.addSubview(lvlNextLabel)
        progressContainer.addSubview(progressBar)
        self.addSubview(happyImage)
        self.addSubview(profileNameLabel)
        self.addSubview(profileLvlLabel)
        self.addSubview(articlesRead)
        self.addSubview(numberOfRead)
        self.addSubview(articlesSaved)
        self.addSubview(numberOfSaved)
        self.addSubview(logoutButton)
    }
    
    private func setupSubviews() {
        self.backgroundColor = .black
        backgroundImage.autoPinEdgesToSuperviewEdges()
        
        happyImage.autoPinEdge(toSuperviewSafeArea: .top, withInset: ProfileProperties.profileInset)
        happyImage.autoPinEdge(toSuperviewSafeArea: .leading, withInset: ProfileProperties.profileInset)
        happyImage.autoSetDimension(.height, toSize: ProfileProperties.imageSize)
        happyImage.autoSetDimension(.width, toSize: ProfileProperties.imageSize)
        happyImage.contentMode = .scaleAspectFit
        
        profileNameLabel.autoAlignAxis(.horizontal, toSameAxisOf: happyImage)
        profileNameLabel.autoPinEdge(.leading, to: .trailing, of: happyImage, withOffset: ViewProperties.edgeMarginInset)
        profileNameLabel.font = UIFont.boldSystemFont(ofSize: 36.0)
        profileNameLabel.textColor = ProfileProperties.sunsetStart
        profileNameLabel.text = "Lukassss"
        
        profileLvlLabel.autoPinEdge(.top, to: .bottom, of: profileNameLabel, withOffset: 2.0)
        profileLvlLabel.autoPinEdge(.leading, to: .trailing, of: happyImage, withOffset: ViewProperties.edgeMarginInset)
        profileLvlLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        profileLvlLabel.textColor = ProfileProperties.sunsetStart
        profileLvlLabel.text = "LEVEL: 8"
        
        progressContainer.autoPinEdge(.top, to: .bottom, of: happyImage, withOffset: 46.0)
        progressContainer.autoPinEdge(toSuperviewSafeArea: .leading, withInset: ProfileProperties.profileInset)
        progressContainer.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: ProfileProperties.profileInset)
        progressContainer.autoSetDimension(.height, toSize: 20.0)
//        progressContainer.backgroundColor = .neonPink
        
        lvlStartLabel.autoPinEdge(.leading, to: .leading, of: progressContainer)
        lvlStartLabel.autoAlignAxis(.horizontal, toSameAxisOf: progressContainer)
        lvlStartLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        lvlStartLabel.textColor = ProfileProperties.sunsetStart
        lvlStartLabel.text = "LVL. 8"
        
        lvlNextLabel.autoPinEdge(.trailing, to: .trailing, of: progressContainer)
        lvlNextLabel.autoAlignAxis(.horizontal, toSameAxisOf: progressContainer)
        lvlNextLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        lvlNextLabel.textColor = ProfileProperties.sunsetStart
        lvlNextLabel.text = "LVL. 9"
        
        progressBar.autoPinEdge(.leading, to: .trailing, of: lvlStartLabel, withOffset: ViewProperties.edgeInset)
        progressBar.autoPinEdge(.trailing, to: .leading, of: lvlNextLabel, withOffset: -ViewProperties.edgeInset)
        progressBar.autoAlignAxis(.horizontal, toSameAxisOf: progressContainer)
        progressBar.autoSetDimension(.height, toSize: 20.0)
        progressBar.setProgress(0.8, animated: false)
        progressBar.clipsToBounds = true
        progressBar.layer.cornerRadius = 10
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = 10
        progressBar.subviews[1].clipsToBounds = true
        progressBar.tintColor = ProfileProperties.sunsetStart
        progressBar.progressImage = UIImage(named: ViewProperties.images.progressGradient)

        articlesRead.autoPinEdge(.top, to: .bottom, of: progressContainer, withOffset: 45.0)
        articlesRead.autoPinEdge(.leading, to: .leading, of: self, withOffset: ProfileProperties.profileInset)
        articlesRead.font = UIFont.boldSystemFont(ofSize: 20.0)
        articlesRead.textColor = ProfileProperties.sunsetEnd
        articlesRead.text = "ARTICLES READ:"

        numberOfRead.autoAlignAxis(.horizontal, toSameAxisOf: articlesRead)
        numberOfRead.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -ProfileProperties.profileInset)
        numberOfRead.font = UIFont.boldSystemFont(ofSize: 48.0)
        numberOfRead.textColor = ProfileProperties.sunsetEnd
        numberOfRead.text = "80"
        numberOfRead.textAlignment = .right
        
        articlesSaved.autoPinEdge(.top, to: .bottom, of: numberOfRead, withOffset: 45.0)
        articlesSaved.autoPinEdge(.leading, to: .leading, of: self, withOffset: ProfileProperties.profileInset)
        articlesSaved.font = UIFont.boldSystemFont(ofSize: 20.0)
        articlesSaved.textColor = ProfileProperties.sunsetMiddle
        articlesSaved.text = "ARTICLES SAVED:"
        
        numberOfSaved.autoAlignAxis(.horizontal, toSameAxisOf: articlesSaved)
        numberOfSaved.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -ProfileProperties.profileInset)
        numberOfSaved.font = UIFont.boldSystemFont(ofSize: 48.0)
        numberOfSaved.textColor = ProfileProperties.sunsetMiddle
        numberOfSaved.text = "24"
        numberOfSaved.textAlignment = .right
        
        logoutButton.autoAlignAxis(.vertical, toSameAxisOf: self)
        logoutButton.autoPinEdge(.top, to: .bottom, of: articlesSaved, withOffset: 70.0)
        logoutButton.autoSetDimension(.height, toSize: 90.0)
        logoutButton.layer.cornerRadius = 45.0
        logoutButton.setBackgroundImage(UIImage(named: ViewProperties.images.logout), for: .normal)
        logoutButton.tintColor = .clear
        logoutButton.backgroundColor = ProfileProperties.sunsetStart
    }
}
