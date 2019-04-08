//
//  ContentsCellView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/3.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class StoriesCellView: NSTableCellView {

    @IBOutlet weak var coverView: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var truncatedTextLabel: NSTextField!
    
    override func awakeFromNib() {
        titleLabel.isEditable = false
        truncatedTextLabel.isEditable = false
        truncatedTextLabel.maximumNumberOfLines = 2
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
