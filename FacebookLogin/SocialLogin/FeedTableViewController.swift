//
//  FeedTableViewController.swift
//  
//
//  Created by Blake Becerra on 4/2/17.
//
//

import UIKit
import FirebaseDatabase
var feedRef: FIRDatabaseReference!
var feedContentRef: FIRDatabaseReference!

class FeedTableViewController: UITableViewController {
    var items = [NSString]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedRef = userRef.child("feeds");
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        feedRef.observe(.value){ (snapshot:FIRDataSnapshot!) in
            
            var newItems = [NSString]()
            for item in snapshot.children{
                newItems.append((item as! FIRDataSnapshot).value as! NSString);
            }
            self.items = newItems
            self.tableView.reloadData()
            
        }
        
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
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FeedTableViewCellIdentifier"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FeedTableViewCell else {
            fatalError("The deqeued cell is not an instance of FeedTableViewCell")
        }
        let feed = items[indexPath.row]
        
        cell.feedButton.setTitle(feed as String, for: [])

        return cell
    }
    @IBOutlet weak var NewFeedButton: UIBarButtonItem!
    
    @IBAction func CreateNewFeed(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Feed", message: "Please enter a new feed", preferredStyle: UIAlertControllerStyle.alert)
    
        alertController.addTextField {
            (txtFeed) -> Void in
            txtFeed.placeholder = "<Feed Name Here>"
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (action) -> Void in
            alertController.dismiss(animated: true, completion:nil);
            //if the child exists add it if not do something
            if alertController.textFields?[0].text == nil{
                return
            }
            else{
                feedRef.child((alertController.textFields?[0].text)!).setValue(alertController.textFields?[0].text)
                ref.child("feed").child((alertController.textFields?[0].text)!).child("post").child("1").setValue("fuck");
        }
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil);
    }

}
