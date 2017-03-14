//
//  ViewController.swift
//  SocialLogin
//
//  Created by Cathy Chi on 2/16/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    var user = User()
    var fbDetails = NSDictionary()
    var gatheredInfo = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        view.addSubview(loginView)
        loginView.readPermissions = ["public_profile", "email"]
        loginView.frame = CGRect(x:16, y:50, width: view.frame.width-32, height: 50)
        
        loginView.delegate = self
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        else {
            if result.grantedPermissions.contains("public_profile") {
                let _ = retrieveInformation()
            }
        }
        print("Successfully logged in within Facebook...")
    }
    
    func retrieveInformation() -> User {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, id, name, first_name, gender, birthday, location"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil) {
                self.gatheredInfo = true
                self.fbDetails = result as! NSDictionary
                self.user = self.initializeUser(fbDetails: self.fbDetails)
                self.user.printing()
            }
        })
        return self.user
    }
    
    func initializeUser(fbDetails: NSDictionary) -> User {
        var birthday = ""
        var location = ""
        var first_name = ""
        var name = ""
        var gender = ""
        var email = ""
        if  let _ = fbDetails.value(forKey: "birthday") as? String {
            birthday = fbDetails.value(forKey: "birthday") as! String
        }
        else {
            birthday = "birthday"
        }
        if let _ = fbDetails.value(forKey: "location") as? String {
            location = fbDetails.value(forKey: "location") as! String
        }
        else {
            location = "location"
        }
        if let _ = fbDetails.value(forKey: "gender") as? String {
            gender = fbDetails.value(forKey: "gender") as! String
        }
        else {
            gender = "gender"
        }
        if let _ = fbDetails.value(forKey: "first_name") as? String {
            first_name = fbDetails.value(forKey: "first_name") as! String
        }
        else {
            first_name = "first_name"
        }
        if let _ = fbDetails.value(forKey: "email") as? String {
            email = fbDetails.value(forKey: "email") as! String
        }
        else {
            email = "email"
        }
        if let _ = fbDetails.value(forKey: "name") as? String {
            name = fbDetails.value(forKey: "name") as! String
        }
        else {
            name = "name"
        }
        let user = User(gender: gender, name: name, email: email, birthday: birthday, location: location, first_name: first_name);
         return user
    }
    
}

