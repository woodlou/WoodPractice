//
//  TripViewController.swift
//  TripCard
//
//  Created by Simon Ng on 8/3/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class TripViewController: UIViewController {
    @IBOutlet weak var backgroundImageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Apply blurring effect
        backgroundImageView.image = UIImage(named: "cloud")
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

}
