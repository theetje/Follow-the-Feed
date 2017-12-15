//
//  SavedFeedTableViewController.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 10-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import UIKit

class SavedFeedTableViewController: UITableViewController {
    var SavedArticles = [Article]()
    
    // Actions:
    @IBAction func unwindToSavedTableView(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissOnlineFeed" {
        }
    }
    
    // OVERRIDES:
    override func viewWillAppear(_ animated: Bool) {
        
        if let data = getArticles() {
            SavedArticles = data
        }
        print(SavedArticles.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    //
    func getArticles() -> [Article]? {
        guard let articleData = UserDefaults.standard.object(forKey: "Articles") as? [Data] else { return nil }
        return articleData.flatMap { return Article(data: $0) }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Maak de content van de cellen
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let savedArticle = SavedArticles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlineCellIdentifier", for: indexPath) as! OnlineFeedTableViewCell
        cell.titleLabel.text = savedArticle.author
        cell.descriptionLabel.text = savedArticle.description
        
        ArticleController.shared.fetchImage(url: savedArticle.urlToImage) {
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
            let feedSiteViewController = segue.destination as! SavedFeedViewController
            let index = tableView.indexPathForSelectedRow!.row
            feedSiteViewController.OnlineArticle = SavedArticles[index]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SavedArticles.count
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source swipe to delete
            SavedArticles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            var NewSaves = [Article]()
            for items in SavedArticles {
                NewSaves.append(items)
            }
            ArticleController.shared.saveArticles(arrayArticles: NewSaves)
            print(NewSaves.count)
        }
    }
}
