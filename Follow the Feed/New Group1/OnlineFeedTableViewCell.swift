//
//  OnlineFeedTableViewCell.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 11-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

//extension Data {
//    var hexDescription: String {
//        return reduce("") {$0 + String(format: "%02x", $1)}
//    }
//}

import UIKit
import Firebase
class OnlineFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    // URL paht is alleen om de data in de datase in te laden.
    var UrlPath: URL!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        print("--- OUTPUT ---")
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        // om de data te kunnen gebruiken in de database (met url als key) moet die omgeschreven worden naar een hexString:
        // Een met de string als url en een met counter er achter om te tellen.
        let URLAsString = UrlPath.absoluteString
        let URLAsCounter = URLAsString + "Counter"

        let dataString = URLAsString.data(using: .utf8)!
        let hexString = dataString.map{ String(format:"%02x", $0) }.joined()
        
        let dataCounter = URLAsCounter.data(using: .utf8)!
        let hexCounter = dataCounter.map{ String(format:"%02x", $0) }.joined()
        
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
                var stars: Dictionary<String, Bool>
                //Hier is somstarr dus de naam van het veld
                // En somsetarcounter houd bij hoeveel mensen met ID van hierboven somestar hebben geliked.
                stars = post[hexString] as? [String : Bool] ?? [:]
                var starCount = post[hexCounter] as? Int ?? 0
                if let _ = stars[uid] {
                    // Unstar the post and remove self from stars
                    starCount -= 1
                    stars.removeValue(forKey: uid)
                } else {
                    // Star the post and add self to stars
                    starCount += 1
                    stars[uid] = true
                }
                post[hexCounter] = starCount as AnyObject?
                post[hexString] = stars as AnyObject?
                
                // Set value and report transaction success
                currentData.value = post
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
            
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
