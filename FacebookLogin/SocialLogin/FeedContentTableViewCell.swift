//
//  FeedContentTableViewCell.swift
//  SocialLogin
//
//  Created by Cathy Chi on 4/6/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import UIKit

class FeedContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
