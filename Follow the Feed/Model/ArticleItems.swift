//
//  ArticleItems.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 10-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import Foundation

struct Article: Codable {
    //    var id: String
    var author: String
    var description: String
    var url: URL
    var urlToImage: URL
//    var publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        //    case id
        case author
        case description
        case url
        case urlToImage
//        case publishedAt
    }
}

struct Articles: Codable {
    let articles: [Article]
}
