//
//  APICaller.swift
//  NewsTestApp
//
//  Created by Dmitry Gorbunow on 2/21/23.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=ru&apiKey=e9ef48495a24444ca4a018f6966767b4")
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))
                }
            }
            
        }
        task.resume()
    }
}


