//
//  AddResturantController.swift
//  FoodPin
//
//  Created by wood lou on 16/3/3.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit
import CoreData


class AddResturantController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var nameTexxtField:UITextField!
    @IBOutlet var typeTextField:UITextField!
    @IBOutlet var locationTextField:UITextField!
    @IBOutlet var phoneNumberTextField:UITextField!
    @IBOutlet var yesButton:UIButton!
    @IBOutlet var noButton:UIButton!
    var isVisited = true
    var restaurant:Restaurant!

 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController (imagePicker, animated:true, completion:nil)
                
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String: AnyObject]){
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        let leadingConstrict = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview , attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        leadingConstrict.active = true
        
        let trailingConstrict = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        trailingConstrict.active = true
        
        let topConstrict = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        topConstrict.active = true
        
        let bottomConstrict = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        bottomConstrict.active = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveChange(sender:UIBarButtonItem){
        let name = nameTexxtField.text
        let type = typeTextField.text
        let location = locationTextField.text
        let phoneNumber = phoneNumberTextField.text
        
        //确保必填信息完整
        if name == "" || type == "" || location == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
            return
        
        }
        
        //数据库哦开始啦
        if let managedObjectContex = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContex) as! Restaurant
            restaurant.name = name!
            restaurant.type = type!
            restaurant.location = location!
            restaurant.phoneNumber = phoneNumber!
            
            
            
            if let restaurantImage = imageView.image{
                restaurant.image = UIImagePNGRepresentation(restaurantImage)
            }
            restaurant.isVisited = isVisited
            
            do{
                try managedObjectContex.save()
            }catch {
                print(error)
                return
            }
            }

        
        
//        //打印日志
//        print("Name:\(name)")
//        print("Type:\(type)")
//        print("Location:\(location)")
//        print("Have U Been Here :\(isVisited)")
//        
        //退出编辑界面
        dismissViewControllerAnimated(true, completion: nil)
        
        
        
    }
    
    @IBAction func toogleBeHereButton(sender:UIButton){
        if sender == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor.redColor()
            noButton.backgroundColor = UIColor.grayColor()
        } else if sender == noButton {
            isVisited = false
            yesButton.backgroundColor = UIColor.grayColor()
            noButton.backgroundColor = UIColor.redColor()
        }
        
    }

    
    
    

}
    
    

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


