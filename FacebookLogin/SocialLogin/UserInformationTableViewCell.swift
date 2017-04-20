//
//  UserInformationTableViewCell.swift
//  SocialLogin
//
//  Created by Cathy Chi on 3/15/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import UIKit

class UserInformationTableViewCell: UITableViewCell {

    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var userInput: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
