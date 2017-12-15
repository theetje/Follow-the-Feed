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
    
    // ACTIONS:
    @IBAction func unwindToSavedTableView(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissOnlineFeed" {
        }
    }
    
    // OVERRIDES:
    override func viewWillAppear(_ animated: Bool) {
        // Haal de opgeslagen articelen op.
        if let data = ArticleController.shared.getArticles() {
            SavedArticles = data
        }
        print(SavedArticles.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Maak de content van de cellen
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let savedArticle = SavedArticles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnlineCellIdentifier", for: indexPath) as! OnlineFeedTableViewCell
        cell.titleLabel.text = savedArticle.author
        cell.descriptionLabel.text = savedArticle.description
        
        // Apart weer de foto ophalen.
        ArticleController.shared.fetchImage(url: savedArticle.urlToImage) {
            (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.titleImage.image = image
            }
        }
        return cell
    }
    
    // Laat de data zien die achter de opgelsagen artikelen zit.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSite" {
            let feedSiteViewController = segue.destination as! SavedFeedViewController
            let index = tableView.indexPathForSelectedRow!.row
            feedSiteViewController.OnlineArticle = SavedArticles[index]
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SavedArticles.count
    }
    
    // Hier wordt het mogelijk om iets te laten verdwijnen. Zolang het een artikel is.
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
