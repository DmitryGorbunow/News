//
//  APIResponse.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/21/23.
//

import Foundation

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}
