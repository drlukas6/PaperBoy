//
//  Article.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 27/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation

struct Article: Codable {
    var source: sourceReference
    var author: String?
    var title: String
    var description: String?
    var url: URL
    var urlToImage: URL?
    var publishedAt: String
}

struct sourceReference: Codable {
    var id: String?
    var name: String?
}

struct Articles: Codable {
    var articles: [Article]
}
