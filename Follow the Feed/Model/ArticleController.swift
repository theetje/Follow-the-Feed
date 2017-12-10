//
//  ArticleController.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 10-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import Foundation

class ArticleControler {
    static let shared = ArticleControler()
    
    let baseURL = URL(string: "https://newsapi.org/v2/top-headlines?language=nl&apiKey=cc5525640ac54790a4a1c58bea987641")!
    
    func fetchFeed(completion: @escaping ([Article]?) -> Void) {
        // Hier haal je de baseURL op maar misschien dat dit niet de manier is om hem aan te roepen
        let task = URLSession.shared.dataTask(with: baseURL.absoluteURL) {
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let articleItems = try? jsonDecoder.decode(Articles.self, from: data) {
                completion(articleItems.articles)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
}
