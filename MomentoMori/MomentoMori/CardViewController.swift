//
//  ViewController.swift
//  MomentoMori
//
//  Created by wood lou on 16/5/8.
//  Copyright © 2016年 wood lou. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        @IBOutlet var settingButton:UIButton!

    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // backgroundImageView.image = UIImage(named: "horse")
        // let blurEffect = UIBlurEffect(style: .Dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        backgroundImageView.addSubview(blurEffectView)
//        collectionView.backgroundColor = UIColor.clearColor()
        getCards()
        
        collectionView.pagingEnabled = true

        
        
        
        collectionView.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //显示
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {   let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CardCollectionViewCell
        let imageDataString = cards[indexPath.row].cardImageURL!
        let imageDataURL = NSURL(string:imageDataString)
        let imageData = NSData(contentsOfURL:imageDataURL!)
        cell.imageView.image = UIImage(data: imageData!)
        
        //日期怎么转不过来…
//        let dateString = cards[indexPath.row].date
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "'\"'yyyy-MM-dd'T'hh:mm:ss'\"'"
//        let date1 = dateFormatter.dateFromString(dateString!)
//        print(date1)
//
//        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
//        let convertedDate = dateFormatter.stringFromDate(date1!)
//        cell.dateLable.text = convertedDate
        
        
        //linkTitle:UILabel!
        //copyButton:UIButton!
        //likeButton:UIButton!
        //shareButton:UIButton!
        cell.imageView.clipsToBounds = true
         return cell
        
    
    }
    
    
    

    
    

    let cardURL = "https://api.pinterest.com/v1/boards/woood/momento-mori/pins/?access_token=ARZtd_antIzxhC4Nv0UNlLR0iPT8FEyUh5p87LJDE5eyVwBHSQAAAAA&fields=id%2Cnote%2Cimage%2Coriginal_link%2Ccreated_at"
    var cards = [Card]()
    
    func getCards(){
        let request = NSURLRequest(URL: NSURL(string: cardURL)!)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self.cards = self.parseJsonData(data)
                
                // Reload table view
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.collectionView.reloadData()
                })
                
            }
            
        })
        
        task.resume()
    }
    
    
    func parseJsonData(data: NSData) -> [Card] {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            
            
            let jsonCards = jsonResult?["data"] as! [AnyObject]
            for jsonCard in jsonCards {
                let card = Card()
            //card.cardCaption = jsonCard["note"] as! String
               card.date = jsonCard["created_at"] as? String
               //card.cardURL = jsonCard["original_link"] as! NSURL
                let image = jsonCard["image"] as! [String:AnyObject]
                let original = image["original"] as! [String:AnyObject]
                card.cardImageURL = original["url"] as? String
                cards.append(card)
                
                print(card.date)
                print(image)
                print(original)
                print(card.cardImageURL)
                
                


                
                
                
            }
            } catch {
                print(error)
            }
        
            return cards
        }

    }
    
