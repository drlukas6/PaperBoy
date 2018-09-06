//
//  HeadlinesViewController.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 28/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit
import SafariServices
import TrapperKeeper
import Kingfisher

class HeadlinesViewController: UIViewController {

    private var headlinesView: HeadlinesView!
    private var dataSource: ArticlesDataSource!
    private var headlinessViewModel: HeadlinesViewModel!
    
    convenience init(dataSource: ArticlesDataSource, currentUser: Users, viewControllersToUpdate: [UserUpdater]?) {
        self.init()
        self.dataSource = dataSource
        self.headlinessViewModel = HeadlinesViewModel(dataSource: dataSource, currentUser: currentUser, updaters: viewControllersToUpdate)
        headlinesView = HeadlinesView(frame: .zero)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Headlines"
        
        
        view.addSubview(headlinesView)
        headlinesView.autoPinEdgesToSuperviewEdges()
        
        setupTableview()
        setupBinding()
        setupActions()
        
        headlinessViewModel.fetchArticles(category: NewsApiPropertyKeys.categories.general)
    }
    
    private func setupTableview() {
        headlinesView.headlinesTableView.delegate = self
        headlinesView.headlinesTableView.dataSource = dataSource
        headlinesView.headlinesTableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
    }
    
    private func setupBinding() {
        headlinessViewModel.dataSource?.data.bind(listener: { (articles) in
            self.headlinesView.headlinesTableView.reloadData()
        })
//        dataSource.data.bind { (articles) in
//            self.headlinesView.headlinesTableView.reloadData()
//        }
    }
    
    private func setupActions() {
        headlinesView.general.addTarget(self, action: #selector(grabCategory(_:)), for: .touchUpInside)
        headlinesView.health.addTarget(self, action: #selector(grabCategory(_:)), for: .touchUpInside)
        headlinesView.business.addTarget(self, action: #selector(grabCategory(_:)), for: .touchUpInside)
        headlinesView.entertainment.addTarget(self, action: #selector(grabCategory(_:)), for: .touchUpInside)
        headlinesView.science.addTarget(self, action: #selector(grabCategory(_:)), for: .touchUpInside)
        headlinesView.sports.addTarget(self, action: #selector(grabCategory(_:)), for: .touchUpInside)
        headlinesView.technology.addTarget(self, action: #selector(grabCategory(_:)), for: .touchUpInside)
    }
    
    @objc
    private func grabCategory(_ sender: UIButton) {
        headlinessViewModel.fetchArticles(category: sender.titleLabel?.text?.lowercased() ?? NewsApiPropertyKeys.categories.general)
    }

}

extension HeadlinesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        headlinesView.headlinesTableView.deselectRow(at: indexPath, animated: false)
        let url = headlinessViewModel.dataSource?.data.value[indexPath.section].url
        if let url = url {
            headlinessViewModel.updateArticlesRead()
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let flagAction = saveArticle(at: indexPath)
        return UISwipeActionsConfiguration(actions: [flagAction])
    }
    
    
    private func saveArticle(at indexPath: IndexPath) -> UIContextualAction {
        let saveAction = UIContextualAction(style: .normal, title: "Save") { (action, view, handler) in
            if let selectedArticle = self.headlinessViewModel.dataSource?.data.value[indexPath.section] {
                let articleToSave = SavedArticles(context: PersistenceService.context)
                articleToSave.articleDescription = selectedArticle.description
                articleToSave.author = selectedArticle.author
                articleToSave.source = selectedArticle.source.name
                articleToSave.title = selectedArticle.title
                articleToSave.url = selectedArticle.url
                if let imageUrl = selectedArticle.urlToImage {
//                    One could have used Swift 3.x+ feature ImageDownloader but with KingFisher added benefit is catching the image
                    KingfisherManager.shared.retrieveImage(with: imageUrl, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            articleToSave.image = image?.pngData() as NSData?
                        }
                        self.headlinessViewModel.saveArticle(for: articleToSave)
                    })
                }
                self.headlinessViewModel.updateArticlesSaved()
                handler(true)
            }
            else {
                handler(false)
            }
        }
        saveAction.image = UIImage(named: ViewProperties.images.save)
        saveAction.backgroundColor = .neonPurple
        return saveAction
    }
}



