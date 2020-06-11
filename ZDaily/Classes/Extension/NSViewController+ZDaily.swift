//
//  NSViewController+ZDaily.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/11.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

extension NSViewController {
    
    struct RuntimeKey {
        static let indicatorKey = UnsafeRawPointer.init(bitPattern: "ZDIndicatorKey".hashValue)!
    }
    
    var activityIndicator: NSProgressIndicator? {
//        set {
//            objc_setAssociatedObject(self, NSViewController.RuntimeKey.indicatorKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
        
        get {
            var indicator = objc_getAssociatedObject(self, NSViewController.RuntimeKey.indicatorKey) as? NSProgressIndicator
            if indicator == nil {
                objc_setAssociatedObject(self, NSViewController.RuntimeKey.indicatorKey, _setupActivityIndicator(), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                indicator = objc_getAssociatedObject(self, NSViewController.RuntimeKey.indicatorKey) as? NSProgressIndicator
            }
            return indicator
        }
    }
    
    func _setupActivityIndicator() -> NSProgressIndicator {
        let indicator = NSProgressIndicator()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isDisplayedWhenStopped = false
        indicator.isIndeterminate = true
        indicator.style = .spinning
        
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.widthAnchor.constraint(equalToConstant: 25),
            indicator.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        return indicator
    }
    
}
