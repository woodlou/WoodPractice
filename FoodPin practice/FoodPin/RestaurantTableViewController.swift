//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Simon Ng on 14/8/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    var searchController:UISearchController!
    var fetchResultController: NSFetchedResultsController!
    var searchResults:[Restaurant] = []
    
    func filterContentForSearchText(searchText:String){
        searchResults = restaurants.filter({ (restaurant:Restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options:NSStringCompareOptions.CaseInsensitiveSearch)
            let locationMatch = restaurant.location.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return  ((nameMatch != nil) || (locationMatch != nil))
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
        
    }
    
    

    
    var restaurants:[Restaurant] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //加搜索栏
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do{
                try fetchResultController.performFetch()
                restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            } catch{
                print(error)
            }
        }
        
        searchController.searchBar.placeholder = "Search Cafe..."
        
        
        
        
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.barTintColor = UIColor(red:0.25, green:0.68, blue:0.93, alpha:1)
        searchController.searchBar.searchBarStyle = .Prominent
        searchController.searchBar.layer.borderWidth = 0

        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 判断引导页是否已出现过
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasViewedwalkthrough = defaults.boolForKey("hasViewedwalkthrough")
        if hasViewedwalkthrough {
            return
        }
        //增加引导页
        if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughPageViewController") as? WalkthroughPageViewController{
            presentViewController(pageViewController, animated: true, completion: nil)
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
  
        
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    
    // 监测数据库变化
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
            
        case .Update:
            if let _indexPath = indexPath{
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
            
        default:
            tableView.reloadData()
            
            }
        restaurants = controller.fetchedObjects as! [Restaurant]
        
        }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active{
            return searchResults.count
        } else {
        return restaurants.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        
        // 增加搜索结果的逻辑
        let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        // Configure the cell...
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data:restaurant.image!)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        if let isVisited = restaurant.isVisited?.boolValue{
        cell.accessoryType = isVisited ? .Checkmark : .None
        }
        
        
        
        return cell
    }
    
    // MARK: - Table view delegate
 
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            restaurants.removeAtIndex(indexPath.row)
        }
        
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Share", handler: { (action, indexPath) -> Void in
            
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
            if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image!) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            }
        })
        
        // 删除数据
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete",handler: { (action, indexPath) -> Void in
            
            //删除数据库文件
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                managedObjectContext.deleteObject(restaurantToDelete)
                do{
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
                }
            })
            

        
        
        
        
        
        
        // Set the button color
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)

        return [deleteAction, shareAction]
    }
    
    //搜索页禁用单行编辑
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        } else {
            return true
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! RestaurantDetailViewController
                destinationController.restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
    }
    

}

