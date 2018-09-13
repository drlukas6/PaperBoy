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
    private var headlinesViewModel: HeadlinesViewModel!
    private var activeCategory: String = NewsApiPropertyKeys.categories.general
    
    convenience init(dataSource: ArticlesDataSource, currentUser: Users, viewControllersToUpdate: [UserUpdater]?) {
        self.init()
        self.dataSource = dataSource
        self.headlinesViewModel = HeadlinesViewModel(dataSource: dataSource, currentUser: currentUser, updaters: viewControllersToUpdate)
        headlinesView = HeadlinesView(frame: .zero)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Headlines"
        self.hideKeyboardWhenTappedAround()
        
        view.addSubview(headlinesView)
        headlinesView.autoPinEdgesToSuperviewEdges()
        
        setupTableview()
        setupBinding()
        setupActions()
        
        startLoading()
        
        headlinesViewModel.fetchArticles(prompt: activeCategory, searchType: .top)
    }
    
    private func setupTableview() {
        headlinesView.headlinesTableView.delegate = self
        headlinesView.headlinesTableView.dataSource = dataSource
        headlinesView.headlinesTableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        headlinesView.searchBar.delegate = self
    }
    
    private func setupBinding() {
        headlinesViewModel.dataSource?.data.bind(listener: { [weak self] (articles) in
            self?.stopLoading()
            self?.headlinesView.headlinesTableView.reloadData()
            self?.resignFirstResponder()
        })
        
        headlinesViewModel.fetchErrorStatus.bind { [weak self] errorStatus in
            if errorStatus {
                self?.stopLoading()
                self?.showToast(message: "Error Fetching Category", backgroundColor: .sunsetStart)
            }
        }
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
    
    private func startLoading() {
        headlinesView.loadingActivity.isHidden = false
        headlinesView.loadingActivity.startAnimating()
    }
    
    private func stopLoading() {
        headlinesView.loadingActivity.isHidden = true
        headlinesView.loadingActivity.stopAnimating()
    }
    
    @objc
    private func grabCategory(_ sender: UIButton) {
        activeCategory = sender.titleLabel?.text?.lowercased() ?? NewsApiPropertyKeys.categories.general
        startLoading()
        headlinesViewModel.fetchArticles(prompt: activeCategory, searchType: .top)
    }
    
    @objc
    private func searchArticles() {
        guard let text = headlinesView.searchBar.text else { return }
        startLoading()
        if text == "" {
            headlinesViewModel.fetchArticles(prompt: activeCategory, searchType: .top)
        }
        else {
            headlinesViewModel.fetchArticles(prompt: text, searchType: .search)
        }
    }
}

extension HeadlinesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        headlinesView.headlinesTableView.deselectRow(at: indexPath, animated: false)
        let url = headlinesViewModel.dataSource?.data.value[indexPath.section].url
        if let url = url {
            headlinesViewModel.updateArticlesRead()
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
        let saveAction = UIContextualAction(style: .normal, title: "Save") { [weak self] (action, view, handler) in
            if let selectedArticle = self?.headlinesViewModel.dataSource?.data.value[indexPath.section] {
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
                        self?.headlinesViewModel.saveArticle(for: articleToSave)
                    })
                }
                self?.headlinesViewModel.updateArticlesSaved()
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

extension HeadlinesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchArticles), object: nil)
        self.perform(#selector(searchArticles), with: nil, afterDelay: 0.3)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchArticles), object: nil)
        self.perform(#selector(searchArticles), with: nil, afterDelay: 0.3)
        self.resignFirstResponder()
    }
}




