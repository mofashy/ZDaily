//
//  NSColor+ZDaily.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/4.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

extension NSColor {
    convenience init(hex: Int) {
        self.init(red: (CGFloat)((hex & 0xFF0000) >> 16) / 255.0, green: (CGFloat)((hex & 0x00FF00) >> 8) / 255.0, blue: (CGFloat)(hex & 0x0000FF) / 255.0, alpha: 1.0)
    }
}
