//
//  SavedViewModel.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 04/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation

class SavedViewModel {
    weak var dataSource: GenericDataSource<SavedArticles>?
    private var currentUser: Users
    
    init(dataSource: GenericDataSource<SavedArticles>?, currentUser: Users) {
        self.dataSource = dataSource
        self.currentUser = currentUser
    }
}

extension SavedViewModel {
    func fetchArticles() {
        guard let usersArticles = currentUser.savedArticles?.allObjects as? [SavedArticles] else { return }
        dataSource?.data.value = usersArticles
    }
    
    func forgetArticle(for article: SavedArticles) {
        currentUser.removeFromSavedArticles(article)
        PersistenceService.saveContext()
    }
    
    func getSavedArticle(at index: IndexPath) -> SavedArticles? {
        return dataSource?.data.value[index.section]
    }
}

