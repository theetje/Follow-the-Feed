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
    
    var OnlineArticle: Article!
    // OUTLET:
    @IBOutlet weak var PageView: WKWebView!
    
    // ACTION:
    // Sla de feed op op het apparaat.
    @IBAction func SaveItem(_ sender: UIBarButtonItem) {
        var NewSaves = [OnlineArticle]
        if let savedItems = ArticleController.shared.getArticles() {
            for items in savedItems {
                NewSaves.append(items)
            }
        }
        ArticleController.shared.saveArticles(arrayArticles: NewSaves as! [Article])
    }
    
    // OVERRIDES:
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
