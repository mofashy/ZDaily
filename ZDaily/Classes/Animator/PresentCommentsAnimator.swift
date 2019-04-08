//
//  PresentCommentsAnimator.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/4.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class PresentCommentsAnimator: NSObject {
    
}

extension PresentCommentsAnimator: NSViewControllerPresentationAnimator {
    
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        let containerView = fromViewController.view
        
        var finalFrame = NSOffsetRect(fromViewController.view.bounds, fromViewController.view.bounds.width-320, 0)
        finalFrame.size.width = 320
        
        let modalView = viewController.view
        
        modalView.frame = finalFrame
        modalView.setFrameOrigin(NSMakePoint(finalFrame.origin.x+320, finalFrame.origin.y))
        
        containerView.addSubview(modalView)
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.25
            modalView.animator().frame = finalFrame
        }, completionHandler: nil)
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        let startFrame = viewController.view.frame
        
        NSAnimationContext.runAnimationGroup({ (context) in
            context.duration = 0.25
            viewController.view.animator().setFrameOrigin(NSMakePoint(startFrame.origin.x+320, startFrame.origin.y))
        }, completionHandler: {
            viewController.view.removeFromSuperview()
        })
    }
}
