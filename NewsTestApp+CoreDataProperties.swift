//
//  NewsTestApp+CoreDataProperties.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/24/23.
//
//

import Foundation
import CoreData


extension NewsTestApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsTestApp> {
        return NSFetchRequest<NewsTestApp>(entityName: "NewsTestApp")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var publishedAt: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
}

extension NewsTestApp : Identifiable {

}
