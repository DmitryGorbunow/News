//
//  News+CoreDataProperties.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/24/23.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var publishedAt: String?

}

extension News : Identifiable {

}
