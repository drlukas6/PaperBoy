
//
//  File.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 05/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation

class ProfileViewModel {
    private var currentUser: Users
    
    init(currentUser: Users) {
        self.currentUser = currentUser
    }
}

extension ProfileViewModel {
    func getUsername() -> String {
        return currentUser.username ?? ""
    }
    
    func getArticlesSaved() -> Int {
        return Int(currentUser.articlesSaved)
    }
    
    func getArticlesRead() -> Int {
        return Int(currentUser.articlesRead)
    }
    
    
    /// Calculates users level using the paraboloid function because it depends on the number of saved and read articles. Curvature towards saved articles is more level as it is less important than the number of read articles.
    ///
    /// - Returns: Users current level
    func calculateLevel() -> Double {
        // 36 = 6 ^ 2 => 6 is curvature
        let curvatureTowardReadArticles = (pow(Double(currentUser.articlesRead), 2) / 36)
        // 64 = 8 ^ 2 => 8 is curvature
        let curvatureTowardSavedArticles = (pow(Double(currentUser.articlesSaved), 2) / 64)
        return curvatureTowardReadArticles + curvatureTowardSavedArticles
    }
    
    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsPropertyKeys.username)
    }
}
