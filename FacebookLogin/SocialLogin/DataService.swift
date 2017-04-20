//
//  DataService.swift
//  SocialLogin
//
//  Created by Blake Becerra on 4/2/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import Foundation
import Firebase;/Database

class DataService{
    static let dataService = DataService()
    
    var ref: FIRDatabaseReference!
    ref = FIRDatabase.database().reference()
    
    
}
