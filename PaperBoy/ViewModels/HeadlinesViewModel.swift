//
//  HighlightsViewModel.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 27/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import TrapperKeeper

class HeadlinesViewModel {
    weak var dataSource: GenericDataSource<Article>?
    private var currentUser: Users
    
    init(dataSource: GenericDataSource<Article>?, currentUser: Users) {
        self.dataSource = dataSource
        self.currentUser = currentUser
    }
}


extension HeadlinesViewModel {
    func fetchArticles(category: String) {
        TrapperKeeper().requestData(url: NewsApiPropertyKeys.highlightsEndPoint, method: .GET, headers: NewsApiPropertyKeys.apiHeader, parameters: ["country" : "us", "category" : category]) { (response, error) in
            if error == nil, let articles = try? JSONDecoder().decode(Articles.self, from: response) {
                self.dataSource?.data.value = articles.articles
            }
            else {
                print("Failed headlines fetch")
            }
        }
    }
    
    func saveArticle(for article: SavedArticles) {
        self.currentUser.addToSavedArticles(article)
        PersistenceService.saveContext()
    }
}

extension HeadlinesViewModel {
    func updateArticlesRead() {
        currentUser.articlesRead = currentUser.articlesRead + 1
        PersistenceService.saveContext()
    }
    
    func updateArticlesSaved() {
        currentUser.articlesSaved = currentUser.articlesSaved + 1
        PersistenceService.saveContext()
    }
}
