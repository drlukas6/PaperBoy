//
//  HighlightsViewModel.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 27/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import TrapperKeeper

protocol UserUpdater {
    func updateUserInfo()
}

class HeadlinesViewModel {
    weak var dataSource: GenericDataSource<Article>?
    private var currentUser: Users
    private var userUpdaters: [UserUpdater]?
    var fetchErrorStatus: ObserverBox<Bool>
    
    init(dataSource: GenericDataSource<Article>?, currentUser: Users, updaters: [UserUpdater]?) {
        self.dataSource = dataSource
        self.currentUser = currentUser
        self.userUpdaters = updaters
        self.fetchErrorStatus = ObserverBox(observable: false)
    }
}

extension HeadlinesViewModel {
    enum searchType {
        case search
        case top
    }
    
    func fetchArticles(prompt: String, searchType: searchType) {
        var parameters: [String : String] = [:]
        var url = NewsApiPropertyKeys.headlinesEndPoint
        switch searchType {
        case .search:
            parameters["q"] = prompt
            url = NewsApiPropertyKeys.everythingEndPoint
        case .top:
            parameters["category"] = prompt
            parameters["country"] = "us"
        }
        TrapperKeeper().requestData(url: url, method: .GET, headers: NewsApiPropertyKeys.apiHeader, parameters: parameters) { [unowned self] (response, error) in
            if error == nil, let articles = try? JSONDecoder().decode(Articles.self, from: response) {
                self.dataSource?.data.value = articles.articles
                self.fetchErrorStatus.value = false
            }
            else {
                print("Failed headlines fetch")
                self.fetchErrorStatus.value = true
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
        if let userUpdaters = userUpdaters {
            userUpdaters.forEach { $0.updateUserInfo() }
        }
    }
    
    func updateArticlesSaved() {
        currentUser.articlesSaved = currentUser.articlesSaved + 1
        PersistenceService.saveContext()
        if let userUpdaters = userUpdaters {
            userUpdaters.forEach { $0.updateUserInfo() }
        }
    }
}
