//
//  PushAnimator.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa
import QuartzCore

class PushAnimator: NSObject, NSViewControllerPresentationAnimator {
    
    let kPushAnimationDuration = 0.25
    
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        viewController.view.frame = CGRect(x: fromViewController.view.frame.width, y: 0, width: fromViewController.view.frame.width, height: fromViewController.view.frame.height)
        viewController.view.autoresizingMask = [.width, .height]
        fromViewController.view.addSubview(viewController.view)
        let destinationRect: NSRect = fromViewController.view.frame
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = kPushAnimationDuration
            context.timingFunction = CAMediaTimingFunction(name: .easeOut)
            viewController.view.animator().frame = destinationRect
        }, completionHandler: nil)
    }
    
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        let destinationRect: NSRect = NSMakeRect(NSWidth(fromViewController.view.frame),0,NSWidth(fromViewController.view.frame),NSHeight(fromViewController.view.frame))
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = kPushAnimationDuration
            context.timingFunction = CAMediaTimingFunction(name: .easeIn)
            viewController.view.animator().frame = destinationRect
        }, completionHandler: {
            viewController.view.removeFromSuperview()
        })
    }
}

class PushSegue: NSStoryboardSegue {
    override func perform() {
        let vc = self.sourceController as! NSViewController
        let animator = PushAnimator()
        vc.present(self.destinationController as! NSViewController, animator: animator)
    }
}
