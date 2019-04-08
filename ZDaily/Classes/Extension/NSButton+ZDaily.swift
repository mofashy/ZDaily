//
//  ZDaily.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/3.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

enum NSButtonState {
    case normal
    case selected
}

extension NSButton {
    
    func switchState(_ state: NSButtonState) {
        let attrTitle = NSMutableAttributedString(attributedString: self.attributedTitle)
        let titleRange = NSMakeRange(0, self.title.count)
        attrTitle.addAttributes([NSAttributedString.Key.foregroundColor: state == .normal ? NSColor.systemGray:NSColor.systemBlue], range: titleRange)
        self.attributedTitle = attrTitle
    }
}
