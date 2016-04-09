//
//  DiscoverTableViewController.swift
//  FoodPin
//
//  Created by wood lou on 16/4/7.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit
import CloudKit


class DiscoverTableViewController: UITableViewController {
    var imageCatch:NSCache = NSCache()
    
    @IBOutlet var spinner:UIActivityIndicatorView!
    
    var restaurants:[CKRecord] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRecordsFromCloud()
        
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.startAnimating()
        
        
        //来下拉刷新
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.whiteColor()
        refreshControl?.tintColor = UIColor.grayColor()
        refreshControl?.addTarget(self, action: "getRecordsFromCloud", forControlEvents: UIControlEvents.ValueChanged)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func getRecordsFromCloud(){
        restaurants.removeAll()
        tableView.reloadData()
        
        
        let cloudContaner = CKContainer.defaultContainer()
        let publicDatebase = cloudContaner.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
//        publicDatebase.performQuery(query, inZoneWithID: nil,completionHandler:  {
//            (results, error) -> Void in
//            
//            if error != nil{
//                print(error)
//                return
//            }
//            if let resuls = results{
//                print("Completed the download of Restaurant data")
//                self.restaurants = resuls
//                self.tableView.reloadData()
//            }
//            
//        })
        
        //上面用的是convenience API，下面用operation
        
        
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.desiredKeys = ["name"]
        queryOperation.queuePriority = .VeryHigh
        queryOperation.resultsLimit = 50
        queryOperation.recordFetchedBlock = {(record:CKRecord!)-> Void in
            if let restaurantRecord = record {
                self.restaurants.append(restaurantRecord)
            }
            
        }
        
        queryOperation.queryCompletionBlock = {(cursor:CKQueryCursor?,error:NSError?)-> Void in
            if (error != nil){
                print("failed to get data from iCloud - \(error!.localizedDescription)")
                return
                
            }
            
            print("successfully retrieve the data from iCloud")
            
            
            NSOperationQueue.mainQueue().addOperationWithBlock(){
                self.spinner.stopAnimating()
                self.tableView.reloadData()
            }
        self.refreshControl?.endRefreshing()

        }
      
        
        publicDatebase.addOperation(queryOperation)
        
        
    }
    
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        let restaurant = restaurants[indexPath.row]
        cell.textLabel?.text = restaurant.objectForKey("name")as? String
        cell.imageView?.image = UIImage(named: "photoalbum")
        //先检查有没有缓存
        
        if let imageFileURL = imageCatch.objectForKey(restaurant.recordID) as? NSURL {
            print("get image from cache")
            cell.imageView?.image = UIImage(data: NSData(contentsOfURL: imageFileURL)!)
        }
        else{
        
        
        //开始获取真实图片
        let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
        let fetchRecordsImageOperation = CKFetchRecordsOperation(recordIDs:[restaurant.recordID])
        fetchRecordsImageOperation.desiredKeys = ["image"]
        fetchRecordsImageOperation.queuePriority = .VeryHigh
        
        fetchRecordsImageOperation.perRecordCompletionBlock = {
            (record:CKRecord?, recordID:CKRecordID?,error:NSError?) -> Void in
            if (error != nil){
                print("fail")
                return
            }
            if let restaurantRecord = record {
                NSOperationQueue.mainQueue().addOperationWithBlock(){
                    if let imageAsset = restaurantRecord.objectForKey("image")as? CKAsset{
                        cell.imageView?.image = UIImage(data: NSData(contentsOfURL: imageAsset.fileURL)!)
                        
                        //加载成功之后放进缓存
                        self.imageCatch.setObject(imageAsset.fileURL, forKey: restaurant.recordID)
                    }
            
        }
            }
            }
        
    
        publicDatabase.addOperation(fetchRecordsImageOperation)
        
        }
        
//        
//        if let image = restaurant.objectForKey("image")
//        {
//            let imageAsset = image as! CKAsset
//            cell.imageView?.image = UIImage(data: NSData (contentsOfURL:imageAsset.fileURL)!)
//        }
//        
        
        
        

        return cell
    }
   

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

}
