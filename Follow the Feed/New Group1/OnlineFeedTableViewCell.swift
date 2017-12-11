//
//  OnlineFeedTableViewCell.swift
//  Follow the Feed
//
//  Created by Thomas De lange on 11-12-17.
//  Copyright © 2017 Thomas De lange. All rights reserved.
//

import UIKit

class OnlineFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
