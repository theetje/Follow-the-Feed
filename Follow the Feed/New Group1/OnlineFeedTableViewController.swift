//
//  OnlineFeedTableViewController.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 10-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import UIKit

class OnlineFeedTableViewController: UITableViewController {
    var OnlineArticles = [Article]()
//    var articles = [Article]()
    // OUTPUTS:
    
    // ACTIONS:
        @IBAction func unwindToOnlineTableView(segue: UIStoryboardSegue) {
            if segue.identifier == "DismissOnlineFeed" {
            }
        }
    
    // OVERRIDE FUNCTIONS:
    override func viewDidLoad() {
        super.viewDidLoad()
        ArticleController.shared.fetchArticles { (articlesOnline) in
            if let articlesOnline = articlesOnline {
                self.updateUI(with: articlesOnline)
            }
        }
        
    }
        
    // Maak de content van de cellen
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let onlineArticle = OnlineArticles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlineCellIdentifier", for: indexPath) as! OnlineFeedTableViewCell
        cell.titleLabel.text = onlineArticle.author
        cell.descriptionLabel.text = onlineArticle.description
        
        ArticleController.shared.fetchImage(url: onlineArticle.urlToImage) {
            (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.titleImage.image = image
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSite" {
            let feedSiteViewController = segue.destination as! FeedSiteViewController
            let index = tableView.indexPathForSelectedRow!.row
            feedSiteViewController.OnlineArticle = OnlineArticles[index]
        }
    }

    // Aantal articelen is count van de Feed
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OnlineArticles.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Aantal secties in te tabel is 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // FUNCTIONS:
    func updateUI(with OnlineArticles: [Article]) {
        DispatchQueue.main.async {
            self.OnlineArticles = OnlineArticles
            self.tableView.reloadData()
        }
    }

}
