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
    @IBOutlet weak var PageView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let webConfiguration = WKWebViewConfiguration()
//        PageView = WKWebView(frame: .zero, configuration: webConfiguration)
//        PageView.uiDelegate = self
//        view = PageView
        
//        let myURL = URL(OnlineArticle.url)
        print(OnlineArticle.url)
        let myRequest = URLRequest(url: OnlineArticle.url)
//        let myRequest = URLRequest(url: myURL!)
        PageView.load(myRequest)
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
