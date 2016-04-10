//
//  DiscoverTableViewCell.swift
//  FoodPin
//
//  Created by wood lou on 16/4/10.
//  Copyright © 2016年 woodme. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel:UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var backgroundImage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
