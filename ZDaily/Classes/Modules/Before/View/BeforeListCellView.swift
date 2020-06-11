//
//  BeforeListCellView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class BeforeListCellView: NSTableCellView {

    @IBOutlet weak var coverView: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    
    var story: Story? {
        didSet {
            guard let s = self.story else { return }
            
            titleLabel.stringValue = s.title ?? ""
            coverView.loadImage(s.images?.first)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.maximumNumberOfLines = 2
    }
    
}
