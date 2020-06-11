//
//  SectionDetailCellView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class SectionDetailCellView: NSTableCellView {

    @IBOutlet weak var coverView: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descLabel: NSTextField!
    
    var story: SectionStory? {
        didSet {
            guard let s = self.story else { return }
            
            titleLabel.stringValue = s.title ?? ""
            descLabel.stringValue = s.display_date ?? ""
            coverView.loadImage(s.images?.first)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descLabel.maximumNumberOfLines = 2
    }
    
}
