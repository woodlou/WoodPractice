//
//  SlideDownTransitionAnimator.swift
//  NavTransition
//
//  Created by wood lou on 16/4/13.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

class SlideDownTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let duration = 0.5
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        // Get reference to our fromView, toView and the container view
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        // Set up the transform we'll use in the animation
        guard let container = transitionContext.containerView() else {
            return
        }
        
        let offScreenUp = CGAffineTransformMakeTranslation(0, -container.frame.height)
        let offScreenDown = CGAffineTransformMakeTranslation(0, container.frame.height)
        

            toView.transform = offScreenUp
        
        // Add both views to the container view
        container.addSubview(fromView)
        container.addSubview(toView)
    

        
        
        
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            fromView.transform = offScreenDown
            fromView.alpha = 0.5
            toView.transform = CGAffineTransformIdentity
            
            }, completion:{ finished in
                transitionContext.completeTransition(true)
        })
    }
    
    
    func animationControllerForPresentedController(presented:UIViewController, presentingController presenting:UIViewController, sourceController source:UIViewController) -> UIViewControllerAnimatedTransitioning?{
        return self
        
    }
    
     func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    

    
    

}
