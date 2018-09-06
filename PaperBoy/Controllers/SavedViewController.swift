//
//  SavedViewController.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 04/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit
import SafariServices

class SavedViewController: UIViewController {

    private var savedView: SavedView!
    private var dataSource: SavedArticlesDataSource!
    
//    lazy var savedViewModel: SavedViewModel = {
//        return SavedViewModel(dataSource: dataSource, currentUser: currentUser)
//    }()
    private var savedViewModel: SavedViewModel!
    
    convenience init(dataSource: SavedArticlesDataSource, currentUser: Users) {
        self.init()
        self.dataSource = dataSource
        self.savedViewModel = SavedViewModel(dataSource: dataSource, currentUser: currentUser)
        savedView = SavedView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Saved"
        
        view.addSubview(savedView)
        savedView.autoPinEdgesToSuperviewEdges()
        
        setupTableView()
        setupBinding()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedViewModel.fetchArticles()
    }
    
    private func setupTableView() {
        savedView.savedTableView.dataSource = dataSource
        savedView.savedTableView.delegate = self
        savedView.savedTableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
    }
    
    private func setupBinding() {
        dataSource.data.bind { (articles) in
            self.savedView.savedTableView.reloadData()
        }
    }

}

extension SavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        savedView.savedTableView.deselectRow(at: indexPath, animated: false)
        let url = savedViewModel.dataSource?.data.value[indexPath.section].url
        if let url = url {
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black
        return headerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = deleteArticle(at: indexPath)
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func deleteArticle(at indexPath: IndexPath) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: "Remove") { (action, view, handler) in
            if let selectedArticle = self.savedViewModel.getSavedArticle(at: indexPath) {
                self.savedViewModel.forgetArticle(for: selectedArticle)
                self.savedViewModel.fetchArticles()
                handler(true)
            }
            else {
                handler(false)
            }
        }
        deleteAction.image = UIImage(named: ViewProperties.images.remove)
        return deleteAction
    }
}

extension SavedViewController: UserUpdater {
    func updateUserInfo() {
        self.savedViewModel.fetchArticles()
    }
}
