//
//  CardCollectionViewCell.swift
//  MomentoMori
//
//  Created by wood lou on 16/5/9.
//  Copyright © 2016年 wood lou. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView:UIImageView! 
   // @IBOutlet var linkTitle:UILabel!
    //@IBOutlet var copyButton:UIButton!
    @IBOutlet var dateLable:UILabel!
    @IBOutlet var likeButton:UIButton!
    @IBOutlet var shareButton:UIButton!
    
    var isLiked:Bool = false  {
        didSet {
            if isLiked {
                likeButton.setImage(UIImage(named: "like_grey"), forState: .Normal)
            } else {
                likeButton.setImage(UIImage(named: "like_red"), forState: .Normal)
            }
        }
    }
    
    

    
    
}
