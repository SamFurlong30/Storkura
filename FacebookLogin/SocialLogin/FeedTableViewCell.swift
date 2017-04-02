//
//  FeedTableViewCell.swift
//  SocialLogin
//
//  Created by Blake Becerra on 3/30/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var feedImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
