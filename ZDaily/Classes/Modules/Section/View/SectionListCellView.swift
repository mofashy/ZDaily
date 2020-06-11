//
//  SectionListCellView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class SectionListCellView: NSTableCellView {
    
    @IBOutlet weak var coverView: NSImageView!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var descLabel: NSTextField!
    
    var section: Section? {
        didSet {
            guard let s = self.section else { return }
            
            titleLabel.stringValue = s.name ?? ""
            descLabel.stringValue = s.description ?? ""
            coverView.loadImage(s.thumbnail)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descLabel.maximumNumberOfLines = 2
    }
    
}
