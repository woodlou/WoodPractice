//
//  TripViewController.swift
//  TripCard
//
//  Created by Simon Ng on 8/3/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class TripViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,TripCollectionCellDelegate {
    @IBOutlet weak var backgroundImageView:UIImageView!
    @IBOutlet var collectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Apply blurring effect
        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        collectionView.backgroundColor = UIColor.clearColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    private var trips = [Trip(tripId: "Paris001", city: "Paris", country: "France", featuredImage: UIImage(named: "paris"), price: 2000, totalDays: 5, isLiked: false),
    Trip(tripId: "Rome001", city: "Rome", country: "Italy", featuredImage: UIImage(named: "rome"), price: 800, totalDays: 3, isLiked: false),
    Trip(tripId: "Istanbul001", city: "Istanbul", country: "Turkey", featuredImage: UIImage(named: "istanbul"), price: 2200, totalDays: 10, isLiked: false),
    Trip(tripId: "London001", city: "London", country: "United Kingdom", featuredImage: UIImage(named: "london"), price: 3000, totalDays: 4, isLiked: false),
    Trip(tripId: "Sydney001", city: "Sydney", country: "Australia", featuredImage: UIImage(named: "sydney"), price: 2500, totalDays: 8, isLiked: false),
    Trip(tripId: "Santorini001", city: "Santorini", country: "Greece", featuredImage: UIImage(named: "santorini"), price: 1800, totalDays: 7, isLiked: false),
    Trip(tripId: "NewYork001", city: "New York", country: "United States", featuredImage: UIImage(named: "newyork"), price: 900, totalDays: 3, isLiked: false),
    Trip(tripId: "Kyoto001", city: "Kyoto", country: "Japan", featuredImage: UIImage(named: "kyoto"), price: 1000, totalDays: 5, isLiked: false)
    ]
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath:indexPath) as! TripCollectionCell
        
        cell.cityLabel.text = trips[indexPath.row].city
        
        cell.countryLabel.text = trips[indexPath.row].country
        cell.imageView.image = trips[indexPath.row].featuredImage
        cell.priceLabel.text = "$\(String(trips[indexPath.row].price))"
        cell.totalDaysLabel.text = "\(trips[indexPath.row].totalDays) days"
        cell.isLiked = trips[indexPath.row].isLiked
        cell.delegate = self
        cell.layer.cornerRadius = 4.0

        return cell
        
        
    }
    
    
    func didLikeButtonPress(cell: TripCollectionCell) {
        if let indexPath = collectionView.indexPathForCell(cell){
            trips[indexPath.row].isLiked = trips[indexPath.row].isLiked ? false : true
            cell.isLiked = trips[indexPath.row].isLiked
        }
    
    }
    
    
    
    
    
    
    

}
