//
//  AnimationController.swift
//  ImagePushAnimationSample
//
//  Created by tanabe yuki on 2016/01/18.
//  Copyright © 2016年 monopocket. All rights reserved.
//

import UIKit

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isForward = true
    var image = UIImage()
    var rectFrom = CGRectZero
    var rectTo = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
           let toView   = transitionContext.viewForKey(UITransitionContextToViewKey),
           let containerView = transitionContext.containerView() {
            
            containerView.addSubview(fromView)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .ScaleAspectFit
            imageView.frame = isForward ? rectFrom : rectTo
            containerView.addSubview(imageView)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                imageView.frame = self.isForward ? self.rectTo : self.rectFrom
                fromView.alpha = 0
                
            }) { (completed) -> Void in
                fromView.removeFromSuperview()
                fromView.alpha = 1
                imageView.removeFromSuperview()
                containerView.addSubview(toView)
                
                transitionContext.completeTransition(true)
            }
        }
    }
}
