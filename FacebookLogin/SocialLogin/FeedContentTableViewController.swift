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
    var flag: Bool = true
    var items = [item]()
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
    struct item {
        var text: String
        var name: String
        var imagePath: String
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        picker.delegate = self
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
                var newItems = [item]()
                
                for item1 in snapshot.children {
                    let snap = item1 as! FIRDataSnapshot
                    var newItem:item = item(text: String(), name:String(), imagePath:String())
                    
                    if (snap.childSnapshot(forPath: "text").exists() && snap.childSnapshot(forPath: "name").exists()){
                        newItem.text = (snap.childSnapshot(forPath: "text").value as! NSString) as String
                        
                        newItem.name = (snap.childSnapshot(forPath: "name").value as! NSString) as String
                        
                        
                    }
                    print(snap.childSnapshot(forPath: "image").exists())
                    if (snap.childSnapshot(forPath: "image").exists()){
                        if (snap.childSnapshot(forPath: "type").exists()) {
                            let number = snap.childSnapshot(forPath: "type").value as! NSNumber
                            let intNumber = Int(number)
                            print(intNumber)
                            
                            if (intNumber == 1) {
                                
                                print("image")
                                newItem.imagePath = (snap.childSnapshot(forPath: "image").value as! NSString as String) as String
                            }
                        }
                    }
                    newItems.append(newItem);
                    
                    
                }
                self.items = newItems
                self.tableView.reloadData()
            }
            
        }
    }
    
    @IBAction func Post(_ sender: Any) {
        
        if(flag){
            flag = false;
            self.alertController.addTextField {
                (txtFeed) -> Void in
                txtFeed.placeholder = "<Post Text Here>"
            }
            
            let addPhotoAction = UIAlertAction(title: "Choose Photo", style: UIAlertActionStyle.default){
                (action) -> Void in
                if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)){
                    self.picker.sourceType = .savedPhotosAlbum
                    self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                    
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
                    feedContentRef.child("post").child(myTimeString).child("name").setValue(SharedManager.sharedInstance.user.name)
                }
                
            }
            
            self.alertController.addAction(okAction)
            self.alertController.addAction(addPhotoAction)
            self.alertController.addAction(addVideoAction)
            
        }
        else{
            self.alertController.textFields?[0].text! = ""
        }
        
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
        
        
        
        let feed = items[indexPath.row]
        
        if(feed.imagePath == String()){
            let cellText = tableView.dequeueReusableCell(withIdentifier: "FeedContentTableViewCellIdentifier", for: indexPath) as? FeedContentTableViewCell
            cellText?.nameLabel.text = feed.name
            cellText?.postLabel.text = feed.text
            return cellText!;
        }
        else {
            let cellImage = tableView.dequeueReusableCell(withIdentifier: "FeedContentTableImageCellIdentifier", for: indexPath) as? FeedContentImageTableViewCell
            print("image")
            cellImage?.nameLabel.text = feed.name
            cellImage?.postLabel.text = feed.text
            
            cellImage?.imageView?.image = pic
            
            return cellImage!
        }
        
    }
    func finishedDownloading(completed: FinishedDownload) {
        
        completed()
    }

    func UIImage loadImage(feed: item){
        let toLoad: FIRStorageReference = storage.reference(forURL: feed.imagePath)
        var pic: UIImage = UIImage()
        toLoad.data(withMaxSize: 1*1024*1024){(data, error)-> Void in
            pic = UIImage(data:data!)!
            
        }
        
        return pic;
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        print("imagePickerController")
        let myImageView = UIImageView()
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        myImageView.contentMode = .scaleAspectFit //3
        // Create a reference to "mountains.jpg"
        
        
        // Create a reference to 'images/mountains.png'
        
        var time = String(NSTimeIntervalSince1970)
        time = String(time.characters.suffix(8))
        let postImagesRef = storageRef.child("images").child(time)
        let imageData = UIImagePNGRepresentation(chosenImage)!
        //
        print("image picked")
        let uploadTask = postImagesRef.put(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("error:");
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL()!.absoluteString
            let postRef:FIRDatabaseReference = feedContentRef.child("post").childByAutoId()
            print(postRef);
            postRef.child("image").setValue(downloadURL)
            print(downloadURL)
            postRef.child("type").setValue(1)
            
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
