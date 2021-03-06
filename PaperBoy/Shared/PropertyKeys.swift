//
//  CoreDataPropertyKeys.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 26/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation

enum CoreDataPropertyKeys {
    static let password = "password"
    static let username = "username"
    static let usersEntity = "Users"
}

enum UserDefaultsPropertyKeys {
    static let username = "username"
}

enum NewsApiPropertyKeys {
    static let apiHeader = ["X-Api-Key" : "d7eb258764e640159b084021d4a1d16c"]
    static let headlinesEndPoint = URL(string: "https://newsapi.org/v2/top-headlines")!
    static let sourcesEndPoint = URL(string: "https://newsapi.org/v2/sources")!
    static let everythingEndPoint = URL(string: "https://newsapi.org/v2/everything")!
    
    enum categories {
        static let general = "general"
        static let health = "health"
        static let business = "business"
        static let entertainment = "entertainment"
        static let science = "science"
        static let sports = "sports"
        static let technology = "technology"
    }
}
