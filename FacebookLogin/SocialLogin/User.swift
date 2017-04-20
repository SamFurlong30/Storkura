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
    var id: String!
    var userInformation = [String]()
    
    init(){}
    
    init(gender: String!, name: String!, email: String!, birthday: String!, location: String!, first_name: String!, id: String!) {
        self.gender = gender
        self.name = name
        self.email = email
        self.birthday = birthday
        self.location = location
        self.first_name = first_name
        self.id = id
        userInformation += [self.name, self.gender, self.email, self.birthday, self.location]

    }
    
    func printing() {
        print(self.name)
        print(self.birthday)
        print(self.email)
        print(self.first_name)
        print(self.gender)
        print(self.location)
        print(self.id)
    }
    
    func toArray() -> [String] {
        userInformation += [self.name, self.gender, self.email, self.birthday, self.location]
        return userInformation
    }
    
    func update(array: [String]) {
        self.userInformation = array
        self.name = array[0]
        let namearray = array[0].components(separatedBy: " ")
        self.first_name = namearray[0]
        self.gender = array[1]
        self.email = array[2]
        self.birthday = array[3]
        self.location = array[4]
    }

}
