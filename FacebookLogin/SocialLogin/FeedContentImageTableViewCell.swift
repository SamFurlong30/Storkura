//
//  FeedContentImageTableViewCell.swift
//  SocialLogin
//
//  Created by Cathy Chi on 4/24/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import UIKit

class FeedContentImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
