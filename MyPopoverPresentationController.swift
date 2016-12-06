//
//  PopoverPresentationController.swift
//  CraftBeer
//
//  Created by Anatoly Esaulov on 05.12.16.
//  Copyright © 2016 Obanze Dev. All rights reserved.
//

import UIKit

class MyPopoverPresentationController: NSObject, UIViewControllerAnimatedTransitioning {

    enum AnimationDirection {
        case Straight
        case Reversed
    }
    
    var initialRect : CGRect = CGRect.zero
    var direction = AnimationDirection.Straight
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        let containerView = transitionContext.containerView
        
        let duration = transitionDuration(using: transitionContext)
                switch direction {
        case .Straight:
            
            toViewController.view.frame = CGRect(x: 0, y: 0, width: fromViewController.view.frame.width - 40, height: UIScreen.main.bounds.height / 1.5)
            toViewController.view.center = fromViewController.view.center
            toViewController.view.alpha = 0.0
            
            containerView.addSubview(toViewController.view)
            toViewController.view.layoutIfNeeded()
            
            UIView.animate(withDuration: duration, animations: {
                toViewController.view.alpha = 0.9
                toViewController.view.layoutIfNeeded()
                
            }) { (finished) in
                transitionContext.completeTransition(true)
            }
            
        case .Reversed:
            
            UIView.animate(withDuration: duration, animations: {
                fromViewController.view.alpha = 0.0
                fromViewController.view.layoutIfNeeded()
                
            }) { (finished) in
                fromViewController.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
            
        }
    }
}
