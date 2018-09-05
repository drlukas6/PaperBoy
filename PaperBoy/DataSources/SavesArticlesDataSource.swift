//
//  SavesArticlesDataSource.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 04/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import Foundation
import UIKit

class SavedArticlesDataSource: GenericDataSource<SavedArticles>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.setupCell(with: data.value[indexPath.section])
        
        return cell
    }
    
}
