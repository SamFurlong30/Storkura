//
//  ViewController.swift
//  SocialLogin
//
//  Created by Cathy Chi on 2/16/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRApp.configure()
        
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        view.addSubview(loginView)
        loginView.readPermissions = ["public_profile", "email"]
        loginView.center = view.center
        
        loginView.delegate = self
    }
    

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
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
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if error != nil {
                // ...
                return
            } else {
                if result.grantedPermissions.contains("public_profile") {
                    self.retrieveInformation()
                }
            }
            print("Successfully logged in within Facebook...")
        }
    }
    
}
