//
//  UserInformationTableViewController.swift
//  SocialLogin
//
//  Created by Cathy Chi on 3/15/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import UIKit

class UserInformationTableViewController: UITableViewController {

    var user = User()
    var information = [String]()
    var UserInformation = [String]()
    var indexRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = SharedManager.sharedInstance.user
        UserInformation = user.toArray()
        let nameLabel = "Name (First Last)"
        let genderLabel =  "Gender (female/male)"
        let emailLabel = "Email (address@website.com)"
        let birthdayLabel = "Date of Birth (mm/dd/yyyy)"
        let locationLabel = "Location (City, State)"
        
        information += [nameLabel, genderLabel, emailLabel, birthdayLabel, locationLabel]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return information.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInformationTableViewCell", for: indexPath) as! UserInformationTableViewCell
        
        cell.informationLabel.text = information[indexPath.row]
        cell.userInput.text = UserInformation[indexPath.row]
        cell.userInput.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        indexRow = indexPath.row
        // Configure the cell...

        return cell
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        UserInformation[indexRow] = textField.text!
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        user.update(array: UserInformation)
        SharedManager.sharedInstance.user = user
    }
 

}
