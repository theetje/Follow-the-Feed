//
//  OnlineFeedTableViewCell.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 11-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import UIKit
import Firebase
class OnlineFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        print("TAP")
        print(titleLabel.text!)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            if var post = currentData.value as? [String : AnyObject], let uid = Auth.auth().currentUser?.uid {
                var stars: Dictionary<String, Bool>
                stars = post["somestars"] as? [String : Bool] ?? [:]
                var starCount = post["somestarCount"] as? Int ?? 0
                if let _ = stars[uid] {
                    // Unstar the post and remove self from stars
                    starCount -= 1
                    stars.removeValue(forKey: uid)
                } else {
                    // Star the post and add self to stars
                    starCount += 1
                    stars[uid] = true
                }
                post["somestarCount"] = starCount as AnyObject?
                post["somestars"] = stars as AnyObject?
                
                // Set value and report transaction success
                currentData.value = post
                print(currentData)
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
