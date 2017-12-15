//
//  SavedFeedViewController.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 14-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import UIKit
import WebKit

class SavedFeedViewController: UIViewController, WKUIDelegate {
    var OnlineArticle: Article!
    
    @IBOutlet weak var PageView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PageView.uiDelegate = self
        print(OnlineArticle.url)
        let myRequest = URLRequest(url: OnlineArticle.url)
        PageView.load(myRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToOnlineTableView(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissOnlineFeed" {
        }
    }

}
