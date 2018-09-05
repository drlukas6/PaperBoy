//
//  SavedArticles+CoreDataProperties.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 05/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedArticles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedArticles> {
        return NSFetchRequest<SavedArticles>(entityName: "SavedArticles")
    }

    @NSManaged public var articleDescription: String?
    @NSManaged public var author: String?
    @NSManaged public var image: NSData?
    @NSManaged public var source: String?
    @NSManaged public var title: String?
    @NSManaged public var url: URL?

}
