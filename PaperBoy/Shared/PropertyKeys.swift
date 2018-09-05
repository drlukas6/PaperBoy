//
//  CoreDataPropertyKeys.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 26/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation

struct CoreDataPropertyKeys {
    static let password = "password"
    static let username = "username"
    static let usersEntity = "Users"
}

struct NewsApiPropertyKeys {
    static let apiHeader = ["X-Api-Key" : "d7eb258764e640159b084021d4a1d16c"]
    static let highlightsEndPoint = URL(string: "https://newsapi.org/v2/top-headlines")!
    static let sourcesEndPoint = URL(string: "https://newsapi.org/v2/sources")!
    
    struct categories {
        static let general = "general"
        static let health = "health"
        static let business = "business"
        static let entertainment = "entertainment"
        static let science = "science"
        static let sports = "sports"
        static let technology = "technology"
    }
}
