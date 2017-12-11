//
//  FeedSiteViewController.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 11-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import UIKit
import WebKit

class FeedSiteViewController: UIViewController, WKUIDelegate {
    // Legacy?:
    var OnlineArticle: Article!
    // OUTLET:
    @IBOutlet weak var PageView: WKWebView!
    
    // ACTION:
    @IBAction func SaveItem(_ sender: UIBarButtonItem) {
        var NewSaves = [OnlineArticle]
        if let savedItems = getArticles() {
            for items in savedItems {
                NewSaves.append(items)
            }
        }
        saveArticles(arrayArticles: NewSaves as! [Article])
    }
    
    func saveArticles(arrayArticles: [Article]) {
        let ArticlesData = arrayArticles.map { $0.encode() }
        UserDefaults.standard.set(ArticlesData, forKey: "Articles")
    }
    
    // TODO: Eventueel weg halen en in een global stoppen.
    func getArticles() -> [Article]? {
        guard let articleData = UserDefaults.standard.object(forKey: "Articles") as? [Data] else { return nil }
        return articleData.flatMap { return Article(data: $0) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PageView.uiDelegate = self
        print(OnlineArticle.url)
        let myRequest = URLRequest(url: OnlineArticle.url)
        PageView.load(myRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
