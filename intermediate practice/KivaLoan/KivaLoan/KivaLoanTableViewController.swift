//
//  KivaLoanTableViewController.swift
//  KivaLoan
//
//  Created by Simon Ng on 20/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class KivaLoanTableViewController: UITableViewController {
    
    let kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"
    var loans = [Loan]()
    
    func getLatestLoan(){
        let request = NSURLRequest(URL: NSURL(string: kivaLoanURL)!)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            
            // JSON 数据处理
            if let data = data {
                self.loans = self.parseJsonDate(data)
                
            // 重取数据？
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.reloadData()
                })
                
            }
        
        })
        
        task.resume()
        
    }
    
    
    func parseJsonDate(data:NSData)->[Loan]{
        var loans = [Loan]()
        do{
            let jsonResult = try  NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            
            //json 数据处理
            let jsonLoans = jsonResult?["loans"] as! [AnyObject]
            for jsonLoan in jsonLoans {
                let loan = Loan()
                loan.name = jsonLoan["name"] as! String
                loan.amount = jsonLoan["loan_amount"] as! Int
                //country 在 location里面
                let location = jsonLoan["location"] as! [String:AnyObject]
                loan.country = location["country"] as! String
                loan.use = jsonLoan["use"] as! String
                loans.append(loan)
                
            }
            
            
            
        }catch {
            print(error)
        }
        return loans
        
        
        
        
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getLatestLoan()

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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return loans.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! KivaLoanTableViewCell

        // Configure the cell...
        
        
        cell.nameLabel.text = loans[indexPath.row].name
        cell.countryLabel.text = loans[indexPath.row].country
        cell.useLabel.text = loans[indexPath.row].use
        cell.amountLabel.text = "$\(loans[indexPath.row].amount)"
        

        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
