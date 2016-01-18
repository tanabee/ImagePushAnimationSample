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
    var rectTo = CGRectZero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
           let toView   = transitionContext.viewForKey(UITransitionContextToViewKey),
           let containerView = transitionContext.containerView() {
            
            // rectTo の計算
            let deviceWidth = UIScreen.mainScreen().bounds.size.width
            let deviceHeight = UIScreen.mainScreen().bounds.size.height
            let imageHeight = image.size.height / image.size.width * deviceWidth
            rectTo = CGRectMake(0, (deviceHeight-imageHeight)/2, deviceWidth, imageHeight)
            
            containerView.addSubview(fromView)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .ScaleAspectFill
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
