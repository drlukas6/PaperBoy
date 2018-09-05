//
//  ArticleCell.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 27/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import Kingfisher

class ArticleCell: UITableViewCell {
    var articleImage: UIImageView!
    var articleTitle: UILabel!
    var articleSource: UILabel!
    var articleDescription: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    func setupCell(with article: Article) {
        articleTitle.text = article.title
        articleSource.text = article.source.name?.uppercased() ?? ""
        articleDescription.text = article.description ?? ""
        grabImage(from: article.urlToImage)
    }
    
    func setupCell(with savedArticle: SavedArticles) {
        articleTitle.text = savedArticle.title ?? ""
        articleSource.text = savedArticle.source?.uppercased() ?? ""
        articleDescription.text = savedArticle.articleDescription ?? ""
        if let image = savedArticle.image as Data? {
            setupLocalImage(with: image)
        }
    }
    
    private func grabImage(from url: URL?) {
        articleImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cache, url) in
            let newImageView = UIImageView(image: image)
            newImageView.backgroundColor = .black
            newImageView.addGradientLayer(frame: self.contentView.bounds, colors: [.clear, .black])
            newImageView.addGradientLayer(frame: self.contentView.bounds, colors: [.black, .clear, .clear, .clear, .clear])
            self.setupBackgroundView(with: newImageView)
        }
    }
    
    private func setupLocalImage(with data: Data) {
        let newImageView = UIImageView(image: UIImage(data: data))
        newImageView.backgroundColor = .black
        newImageView.addGradientLayer(frame: self.contentView.bounds, colors: [.clear, .black])
        newImageView.addGradientLayer(frame: self.contentView.bounds, colors: [.black, .clear, .clear, .clear, .clear])
        self.setupBackgroundView(with: newImageView)
    }
    
    private func setupBackgroundView(with imageView: UIImageView) {
        self.backgroundView = imageView
        self.setNeedsLayout()
    }
    
    private func initializeSubviews() {
        articleImage = UIImageView()
        articleTitle = UILabel()
        articleSource = UILabel()
        articleDescription = UILabel()
    }
    
    private func addSubviews() {
        contentView.addSubview(articleTitle)
        contentView.addSubview(articleSource)
        contentView.addSubview(articleDescription)
    }
    
    private func setupSubviews() {
        self.backgroundColor = .white
        self.backgroundView = UIImageView(image: UIImage(named: "placeholder")!)
        self.selectionStyle = .none
        contentView.layer.cornerRadius = ViewProperties.cornerRadius
        
        articleTitle.autoPinEdge(.top, to: .top, of: contentView, withOffset: ViewProperties.edgeInset)
        articleTitle.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: ViewProperties.edgeInset)
        articleTitle.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -ViewProperties.edgeInset)
        articleTitle.lineBreakMode = .byWordWrapping
        articleTitle.numberOfLines = 0
        articleTitle.font = UIFont.boldSystemFont(ofSize: 18)
        articleTitle.textColor = .neonPink
        
        articleSource.autoPinEdge(.top, to: .bottom, of: articleTitle, withOffset: ViewProperties.edgeInset)
        articleSource.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: ViewProperties.edgeInset)
        articleSource.font = UIFont(name: articleSource.font.fontName, size: 12)
        articleSource.textColor = .neonPurple
        
        articleDescription.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -ViewProperties.edgeInset)
        articleDescription.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: ViewProperties.edgeInset)
        articleDescription.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -ViewProperties.edgeInset)
        articleDescription.font = UIFont(name: articleDescription.font.fontName, size: 14)
        articleDescription.textColor = .neonBlue
        articleDescription.lineBreakMode = .byWordWrapping
        articleDescription.numberOfLines = 0
        
        
    }
}
