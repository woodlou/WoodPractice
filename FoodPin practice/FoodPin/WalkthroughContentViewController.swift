//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by wood lou on 16/3/13.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet var headingLabel:UILabel!
    @IBOutlet var contentLabel:UILabel!
    @IBOutlet var contentImageView:UIImageView!
    @IBOutlet var pageControl:UIPageControl!
    @IBOutlet var forwardButton:UIButton!
    
    var index = 0
    var heading = ""
    var content = ""
    var imageFile = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        
        switch index{
        case 0...1:forwardButton.setTitle("Next", forState: .Normal)
        case 2:forwardButton.setTitle("Done", forState: .Normal)
        default:break
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


//    用更棒的方法来实现
    @IBAction func nextButtonTapped(sender:UIButton){
        switch index{
        case 0...1:
            let pageViewController = parentViewController as! WalkthroughPageViewController
            pageViewController.forward(index)
        case 2:
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey: "hasViewedwalkthrough")
            dismissViewControllerAnimated( true, completion: nil)
        default: break
    }
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
