//
//  reviewViewController.swift
//  FoodPin
//
//  Created by wood lou on 16/2/25.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController  {
    var rating:String?
    @IBOutlet var backgroundImageView:UIImageView!
    @IBOutlet var ratingStackView:UIStackView!
    @IBAction func ratingSelected(sender:UIButton){
        switch (sender.tag){
        case 100: rating = "dislike"
        case 200: rating = "good"
        case 300: rating = "great"
        default: break
        }
        performSegueWithIdentifier("unwindToDetailView", sender: sender)
    }
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        
//        ratingStackView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0, 500)

        ratingStackView.transform = CGAffineTransformConcat(scale, translate)

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [], animations: {
        
        self.ratingStackView.transform = CGAffineTransformIdentity
            
        
        }, completion: nil)
        
        
//        UIView.animateWithDuration(0.7, delay: 0.0, options: [], animations: {
//            self.ratingStackView.transform = CGAffineTransformIdentity
//            },completion: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
