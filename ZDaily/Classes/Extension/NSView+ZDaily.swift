//
//  NSView+ZDaily.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/11.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

protocol NibLoadable {
    
}


extension NibLoadable where Self: NSView {
    
    static func loadFromNib(_ nibname : String? = nil) -> Self? {
        let loadName = nibname == nil ? "\(self)" : nibname!
        var topLevelObjects: NSArray? = NSArray()
        guard Bundle.main.loadNibNamed(loadName, owner: nil, topLevelObjects: &topLevelObjects) else {
            return nil
        }
        guard let objs = topLevelObjects else { return nil }
        let views = (objs as Array).filter { $0 is NSView }
        return views[0] as? Self
    }
    
}
