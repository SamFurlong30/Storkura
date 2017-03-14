//
//  User.swift
//  SocialLogin
//
//  Created by Cathy Chi on 3/13/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import Foundation

class User {
    var name: String!
    var first_name: String!
    var email: String!
    var gender: String!
    var birthday: String!
    var location: String!
    
    init(){}
    
    init(gender: String!, name: String!, email: String!, birthday: String!, location: String!, first_name: String!) {
        self.gender = gender
        self.name = name
        self.email = email
        self.birthday = birthday
        self.location = location
        self.first_name = first_name
    }
    
    func printing() {
        print(self.name)
        print(self.birthday)
        print(self.email)
        print(self.first_name)
        print(self.gender)
        print(self.location)
    }

}
