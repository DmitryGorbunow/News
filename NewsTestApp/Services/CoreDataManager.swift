//
//  CoreDataManager.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/24/23.
//

import Foundation
import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    func createItem(title: String, publishedAt: String, imageData: Data?) {
        let newItem = NewsTestApp(context: context)
        newItem.title = title
        newItem.publishedAt = publishedAt
        newItem.imageData = imageData
        
        do {
            try context.save()
        } catch {
            // error
        }
    }
    
    func deleteItem(item: NewsTestApp) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            // error
        }
    }
}
