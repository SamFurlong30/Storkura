//
//  UserSelectionTableViewController.swift
//  SocialLogin
//
//  Created by Cathy Chi on 4/13/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension UserSelectionTableViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

class UserSelectionTableViewController: UITableViewController {
    
    var IDtoName = [NSString: NSString]()
    var IDs = [NSString]()
    var names = [NSString]()
    var users = [user]()
    var filteredUsers = [user]()
    var filteredNames = [NSString]()
    struct user {
        var name = NSString()
        var id = NSString()
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        ref.child("users").observe(.value) {
            (snapshot : FIRDataSnapshot!) in
            for item in snapshot.children {
                let snapA = (item as! FIRDataSnapshot).key as NSString
                let snapB = item as! FIRDataSnapshot
                let snapchild = snapB.childSnapshot(forPath: "name").value as! NSString
                var userObject = user()
                userObject.id = snapA
                userObject.name = snapchild
                self.users.append(userObject)
            }
            
        }
//        ref.child("users").observe(.value) {
//            (snapshot : FIRDataSnapshot!) in
//            var newItems = [NSString]()
//            for item in snapshot.children {
//                let snap = item as! FIRDataSnapshot
//                newItems.append(snap.childSnapshot(forPath: "name").value as! NSString)
//            }
//            self.names = newItems
//            self.tableView.reloadData()
//        }
//        print(IDs)
//        
//        for (index, element) in IDs.enumerated() {
//            self.IDtoName[element] = names[index]
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredUsers = users.filter { user in
            return user.name.lowercased.contains(searchText.lowercased())
        }
        tableView.reloadData()
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
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredUsers.count
        }
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserSelectionIdentifier", for: indexPath) as? UserSelectionTableViewCell
        var u = user()
        if searchController.isActive && searchController.searchBar.text != "" {
            u.name = filteredUsers[indexPath.row].name as NSString
        } else {
            u.name = users[indexPath.row].name as NSString
        }
        cell?.userLabel.text = u.name as String
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var id = NSString()
        if searchController.isActive && searchController.searchBar.text != "" {
            id = filteredUsers[indexPath.row].id as NSString
        } else {
            id = users[indexPath.row].id as NSString
        }
        ref.child("users").child(id as String).child("feeds").child(feedContentRef.key).setValue(feedContentRef.key)
        self.performSegue(withIdentifier: "backToPostView", sender: self)
        searchController.isActive = false;
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
