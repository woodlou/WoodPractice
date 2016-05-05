//
//  TripCollectionCell.swift
//  TripCard
//
//  Created by wood lou on 16/4/24.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

protocol TripCollectionCellDelegate{
    func didLikeButtonPress(cell:TripCollectionCell)
    
}

class TripCollectionCell: UICollectionViewCell {
    
    var delegate:TripCollectionCellDelegate?
    
    @IBOutlet var imageView:UIImageView!
    @IBOutlet var cityLabel:UILabel!
    @IBOutlet var countryLabel:UILabel!
    @IBOutlet var totalDaysLabel:UILabel!
    @IBOutlet var priceLabel:UILabel!
    @IBOutlet var likeButton:UIButton!
    
    var isLiked:Bool = false {
        didSet {// 监控islike的数据变化
            if isLiked{
                likeButton.setImage(UIImage(named: "heartfull"), forState: .Normal)
            } else {
                likeButton.setImage(UIImage(named: "heart"), forState: .Normal)

            }
        }
    }
    

    

    
    @IBAction func likeButtonTapped(sender:AnyObject){
    delegate?.didLikeButtonPress(self)
    }
    
    

}
