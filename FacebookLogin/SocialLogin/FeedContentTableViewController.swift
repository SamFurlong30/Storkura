//
//  FeedContentTableViewController.swift
//  SocialLogin
//
//  Created by Cathy Chi on 4/6/17.
//  Copyright © 2017 Cathy Chi. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MobileCoreServices
import Firebase
import FirebaseStorage

class FeedContentTableViewController: UITableViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var items = [NSString]()
    var pickerViewData = [NSString]()
    let picker = UIImagePickerController();
    
    let alertController = UIAlertController(title: "Post", message: "Please enter the text for Your Post", preferredStyle: UIAlertControllerStyle.alert)

    @IBAction func AddUser(_ sender: Any) {
        self.performSegue(withIdentifier: "toSelectUser", sender: self)
    }
    //@IBOutlet weak var settingsPickerView: UIPickerView!
    
    
    
//    @IBAction func settingsButton(_ sender: Any) {
//        if (settingsPickerView.isHidden){
//            settingsPickerView.isHidden = false
//            
//        }
//        else{
//            settingsPickerView.isHidden = true
//        
//
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        settingsPickerView.dataSource = self
//        settingsPickerView.delegate = self
//        settingsPickerView.isHidden = true
//        pickerViewData = ["Add User", "Filter Posts"]
//        var toolBar = UIToolbar();
//        toolBar.barStyle = UIBarStyle.default
//        toolBar.isTranslucent = true
//        toolBar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: Selector(("donePicker")))
//        toolBar.setItems([doneButton], animated:true)
//        toolBar.isUserInteractionEnabled = true
//        settingsPick
        self.title = feedContentRef.key
        feedContentRef.child("post").observe(.value){ (snapshot : FIRDataSnapshot!) in
            if(snapshot.hasChildren()){
            var newItems = [NSString]()
                
            for item in snapshot.children {
                let snap = item as! FIRDataSnapshot
                if (snap.childSnapshot(forPath: "text").exists()){
                newItems.append(snap.childSnapshot(forPath: "text").value as! NSString);
                }
                
                
            }
            self.items = newItems
            self.tableView.reloadData()
        }
        }
    }
  
    @IBAction func Post(_ sender: Any) {
        
        
        self.alertController.addTextField {
            (txtFeed) -> Void in
            txtFeed.placeholder = "<Post Text Here>"
        }
        
        let addPhotoAction = UIAlertAction(title: "Choose Photo", style: UIAlertActionStyle.default){
            (action) -> Void in
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)){
                self.picker.sourceType = .savedPhotosAlbum
                print(1);
                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                print(2)
                
                self.picker.modalPresentationStyle = .popover
                let ppc = self.picker.popoverPresentationController
                ppc?.barButtonItem = sender as? UIBarButtonItem
                self.present(self.picker, animated: true, completion: nil)
                
                
            }
        }
        
        let addVideoAction = UIAlertAction(title: "Choose Video", style: UIAlertActionStyle.default){
            (action) -> Void in
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)){
                
                self.picker.allowsEditing = false;
                
                self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                self.picker.sourceType = .savedPhotosAlbum;
                
                self.picker.modalPresentationStyle = .popover
                let ppc = self.picker.popoverPresentationController
                ppc?.barButtonItem = sender as? UIBarButtonItem
                //self.present(self.picker, animated: true, completion: nil)
                self.present(self.picker, animated: true, completion: nil)
            }
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (action) -> Void in
            self.alertController.dismiss(animated: true, completion:nil);
            //if the child exists add it if not do something
            if self.alertController.textFields?[0].text == nil{
                return
            }
            else{
                let name = self.alertController.textFields?[0].text!
                let date = Date()
                let timeInterval = date.timeIntervalSince1970
                let myTime = Int(timeInterval)
                let myTimeString = String(myTime)
                feedContentRef.child("post").child(myTimeString).child("text").setValue(name)
            }
            
        }
        
        
        self.alertController.addAction(okAction)
        self.alertController.addAction(addPhotoAction)
        self.alertController.addAction(addVideoAction)
        self.present(alertController, animated: true, completion: nil);
    }
    
    @IBAction func Filter(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerViewData.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerViewData[row] as String
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if (pickerViewData[row] == "Add User") {
//            print("hi")
//        }
//    }

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedContentTableViewCellIdentifier", for: indexPath) as? FeedContentTableViewCell
        
        let feed = items[indexPath.row]
        cell?.postLabel.text = feed as String
        cell?.nameLabel.text = SharedManager.sharedInstance.user.name
        return cell!
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        print("imagePickerController")
        let myImageView = UIImageView()
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        myImageView.contentMode = .scaleAspectFit //3
        // Create a reference to "mountains.jpg"
        let interval:String = String(format:"%.1f", NSTimeIntervalSince1970)
        
        
        // Create a reference to 'images/mountains.png'
        let uniquepath = "images/" + interval
        
        let postImagesRef = storageRef.child(uniquepath)
        let imageData = UIImagePNGRepresentation(chosenImage)!
        //
        let uploadTask = postImagesRef.put(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("error:");
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL()!.absoluteString
            
            print(downloadURL)
            feedContentRef.child("post").childByAutoId().child("image").setValue(downloadURL)
        }
        
        
        myImageView.image = chosenImage
        picker.dismiss(animated: true, completion: nil)
        self.present(alertController, animated: true, completion: nil);
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        self.present(alertController, animated: true, completion: nil);
        
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
