//
//  CommentListCellView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class CommentListCellView: NSTableCellView {

    @IBOutlet weak var avatarView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var contentLabel: NSTextField!
    
    var comment: Comment? {
        didSet {
            guard let c = self.comment else { return }
            avatarView.loadImage(c.avatar)
            nameLabel.stringValue = c.author ?? ""
            contentLabel.stringValue = c.content ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarView.wantsLayer = true
        avatarView.layer?.cornerRadius = 21
        avatarView.layer?.masksToBounds = true
    }
    
}
