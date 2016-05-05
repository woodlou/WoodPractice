//
//  MenuTransitionManager.swift
//  SlideMenu
//
//  Created by wood lou on 16/4/23.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

@objc protocol MenuTransitionManagerDelegate{
    func dismiss()
}



class MenuTransitionManager: NSObject,UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var delegate:MenuTransitionManagerDelegate?
    
    
    let duration = 0.5
    var isPresenting = false
    
    var snapshot: UIView? {
        didSet{
            if let delegate = delegate{
                let tapGestureRecognizer = UITapGestureRecognizer(target:delegate, action:"dismiss")
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return duration
    }
    
    // 获取上下文界面的信息
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        
        guard let container = transitionContext.containerView() else{
            return
        }
        
        let moveDown = CGAffineTransformMakeTranslation(0, container.frame.height - 150)
        let moveUp = CGAffineTransformMakeTranslation(0, -50)
        
        //把两个页面加到当前动画页面里面，一个暂时性的，为了过渡动画而产生的容器
        if isPresenting{
            toView.transform = moveUp
            snapshot = fromView.snapshotViewAfterScreenUpdates(true)
            container.addSubview(toView)
            container.addSubview(snapshot!)
            
        }
        
        
        
        //执行动画
        UIView.animateWithDuration(duration, delay: 0,usingSpringWithDamping: 0.8,initialSpringVelocity: 0, options: [], animations:{
            if self.isPresenting{
                self.snapshot?.transform = moveDown
                toView.transform = CGAffineTransformIdentity} //CGAffineTransformIdentity 用来回到初始位置
            else {
                self.snapshot?.transform = moveUp
            }
            }, completion:{
                finished in transitionContext.completeTransition(true)
                if !self.isPresenting{
                    self.snapshot?.removeFromSuperview()
                }
            })
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    
    
    

}
