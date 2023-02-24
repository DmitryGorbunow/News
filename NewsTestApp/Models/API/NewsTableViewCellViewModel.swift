//
//  NewsTableViewCellViewModel.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/22/23.
//

import Foundation

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    let publishedAt: String
    
    init(title: String, subtitle: String, imageURL: URL?, publishedAt: String) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.publishedAt = publishedAt
    }
}
