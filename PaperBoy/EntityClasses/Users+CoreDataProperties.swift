//
//  Users+CoreDataProperties.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 05/09/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var password: NSData?
    @NSManaged public var username: String?
    @NSManaged public var articlesRead: Int32
    @NSManaged public var articlesSaved: Int32
    @NSManaged public var savedArticles: NSSet?

}

// MARK: Generated accessors for savedArticles
extension Users {

    @objc(addSavedArticlesObject:)
    @NSManaged public func addToSavedArticles(_ value: SavedArticles)

    @objc(removeSavedArticlesObject:)
    @NSManaged public func removeFromSavedArticles(_ value: SavedArticles)

    @objc(addSavedArticles:)
    @NSManaged public func addToSavedArticles(_ values: NSSet)

    @objc(removeSavedArticles:)
    @NSManaged public func removeFromSavedArticles(_ values: NSSet)

}
