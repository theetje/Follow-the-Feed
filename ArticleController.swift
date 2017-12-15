//
//  ArticleController.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 10-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import Foundation
import UIKit

// Maak een extensie van de URL class om een query mee te geven.
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.flatMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

class ArticleController {
    static let shared = ArticleController(source: "bbc-news")
    var source: String
    
    init(source: String) {
        self.source = source
    }
    
    // Eerste functie die articelen ophaald.
    func fetchArticles(completion: @escaping ([Article]?) -> Void) {
        // URL waar request gedaan wordt
        let baseURL = URL(string: "https://newsapi.org/v2/top-headlines")!
        
        // Querie opdracht
        let query: [String: String] = [
            "apiKey": "cc5525640ac54790a4a1c58bea987641",
            "sources": source,
            ]
        let queryURL = baseURL.withQueries(query)!
        
        // Voer opdracht uit met gegeven querie
        let task = URLSession.shared.dataTask(with: queryURL) {
            (data, response, error) in
            print("QUERIE URL USED:")
            print(queryURL)
            let jsonDeconder = JSONDecoder()
            if let data = data,
                let articleItems = try? jsonDeconder.decode(Articles.self, from: data) {
                completion(articleItems.articles)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Haal apart de foto op.
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    // Extra functie die opslaan van articelen verzorgd.
    func saveArticles(arrayArticles: [Article]) {
        let ArticlesData = arrayArticles.map { $0.encode() }
        UserDefaults.standard.set(ArticlesData, forKey: "Articles")
    }
    
    // Same same but dan ophalen van articelen vanuit UserDefaults.
    func getArticles() -> [Article]? {
        guard let articleData = UserDefaults.standard.object(forKey: "Articles") as? [Data] else { return nil }
        return articleData.flatMap { return Article(data: $0) }
    }

}

