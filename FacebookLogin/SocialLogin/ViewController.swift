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
                retrieveInformation()
            }
        }
        print("Successfully logged in within Facebook...")
    }
    
    func retrieveInformation() {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, id, name, first_name, gender, birthday, location"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil) {
                let fbDetails = result as! NSDictionary
                self.user = self.initializeUser(fbDetails: fbDetails)
                SharedManager.sharedInstance.user = self.user
                self.user.printing()
                self.performSegue(withIdentifier: "toUserInformation", sender: self)
            }
        })
    }
    
    func initializeUser(fbDetails: NSDictionary) -> User {
        var birthday = "birthday"
        var location = "location"
        var first_name = "first_name"
        var name = "name"
        var gender = "gender"
        var email = "email"
        if  let _ = fbDetails.value(forKey: "birthday") as? String {
            birthday = fbDetails.value(forKey: "birthday") as! String
        }
        if let _ = fbDetails.value(forKey: "location") as? String {
            location = fbDetails.value(forKey: "location") as! String
        }
        if let _ = fbDetails.value(forKey: "gender") as? String {
            gender = fbDetails.value(forKey: "gender") as! String
        }
        if let _ = fbDetails.value(forKey: "first_name") as? String {
            first_name = fbDetails.value(forKey: "first_name") as! String
        }
        if let _ = fbDetails.value(forKey: "email") as? String {
            email = fbDetails.value(forKey: "email") as! String
        }
        if let _ = fbDetails.value(forKey: "name") as? String {
            name = fbDetails.value(forKey: "name") as! String
        }
        let user = User(gender: gender, name: name, email: email, birthday: birthday, location: location, first_name: first_name);
         return user
    }
    
}

