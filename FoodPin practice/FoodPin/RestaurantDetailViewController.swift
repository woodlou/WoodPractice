//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 19/8/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var ratingButton: UIButton!
    @IBOutlet var restaurantImageView:UIImageView!
    
    @IBOutlet var tableView:UITableView!


    
    
    var restaurant:Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
        restaurantImageView.image = UIImage(data: restaurant.image!)
        
        // Change the color of the table view
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        
        // Remove the separators of the empty rows
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Change the color of the separator
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        // Set the title of the navigation bar
        title = restaurant.name
        if let rating = restaurant.rating where rating != "" {
            ratingButton.setImage(UIImage(named: restaurant.rating!), forState: UIControlState.Normal)
        }
        
    }
    
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RestaurantDetailTableViewCell
        
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restaurant.phoneNumber
        case 4:
            cell.fieldLabel.text = "Been here"
            if let isVisited = restaurant.isVisited?.boolValue{
            cell.valueLabel.text = isVisited ? "Yes, I've been here before" : "No"
            }
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        if let reviewViewController = segue.sourceViewController as? ReviewViewController{
            if let rating = reviewViewController.rating{
                restaurant.rating = rating
                ratingButton.setImage(UIImage(named: rating),forState:UIControlState.Normal)
                
                if let ManagedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
                    do{
                        try ManagedObjectContext.save()
                        
                    } catch{
                        print(error)
                    }
                }
            }
        }
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap"{
            let destinationController = segue.destinationViewController as! MapViewController
            destinationController.restaurant = restaurant
            
    }

}
}
