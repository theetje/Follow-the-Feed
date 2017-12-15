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
    
    @IBAction func unwindToSavedTableView(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissOnlineFeed" {
        }
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
