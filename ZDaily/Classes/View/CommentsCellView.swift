//
//  CommentsCellView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/4.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa
import Kingfisher

class CommentsHeaderView: NSTableHeaderView {
    
    private var closeButton = NSButton()
    private var effectView = NSVisualEffectView()
    
    var closeHandler: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if #available(OSX 10.14, *) {
            effectView.material = .underWindowBackground
        } else {
            // Fallback on earlier versions
            effectView.material = .sidebar
        }
        effectView.blendingMode = .behindWindow
        effectView.state = .followsWindowActiveState
        effectView.frame = bounds
        addSubview(effectView)
        
        closeButton.frame = NSRect(x: 0, y: 0, width: 30, height: 27)
        closeButton.isBordered = false
        closeButton.image = NSImage(named: "right")
//        closeButton.imagePosition = .imageLeft
        closeButton.title = ""
        closeButton.target = self
        closeButton.action = #selector(closeAction(_:))
        addSubview(closeButton)
    }
    
    @objc func closeAction(_ sender: NSButton) {
        guard let handler = closeHandler else {
            return
        }
        handler()
    }
    
}


class CommentsCellView: NSTableCellView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}


class CommentsCellViewSimple: CommentsCellView {
    
    @IBOutlet weak var avatarView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var contentLabel: NSTextField!
    @IBOutlet weak var likesButton: NSButton!
    
    var comment: Comment? {
        didSet {
            guard comment != nil else {
                return
            }
            let processor = DownsamplingImageProcessor(size: CGSize(width: 30, height: 30))
            avatarView.kf.setImage(
                with: URL(string: comment!.avatar),
                placeholder: nil,
                options: [
                    .processor(processor),
                    .scaleFactor(NSScreen.main!.backingScaleFactor),
                    .transition(.none),
                    .cacheOriginalImage
                ])
            nameLabel.stringValue = comment?.author ?? ""
            timeLabel.stringValue = SingleDateFormatter.shared.humanFormattedDate(comment!.time)
            contentLabel.stringValue = comment?.content ?? ""
            likesButton.title = comment!.likes > 0 ? "\(comment!.likes)" : ""
        }
    }
    
}


class CommentsCellViewComplex: CommentsCellView {
    
    @IBOutlet weak var avatarView: NSImageView!
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var contentLabel: NSTextField!
    @IBOutlet weak var replayToLabel: NSTextField!
    @IBOutlet weak var likesButton: NSButton!
    
    var comment: Comment? {
        didSet {
            guard comment != nil else {
                return
            }
            let processor = DownsamplingImageProcessor(size: CGSize(width: 30, height: 30))
            avatarView.kf.setImage(
                with: URL(string: comment!.avatar),
                placeholder: nil,
                options: [
                    .processor(processor),
                    .scaleFactor(NSScreen.main!.backingScaleFactor),
                    .transition(.none),
                    .cacheOriginalImage
                ])
            nameLabel.stringValue = comment?.author ?? ""
            timeLabel.stringValue = SingleDateFormatter.shared.humanFormattedDate(comment!.time)
            contentLabel.stringValue = comment?.content ?? ""
            likesButton.title = comment!.likes > 0 ? "\(comment!.likes)" : ""
            
            let author = comment!.reply_to!.author
            var text = "回复"+author+"："+comment!.reply_to!.content
            if comment!.reply_to!.status != 0 {
                text = comment!.reply_to!.error_msg
            }
            let attrs = NSMutableAttributedString(string: text)
            if comment!.reply_to!.status == 0 {
                let range = NSMakeRange(2, author.count)
                attrs.addAttributes([NSAttributedString.Key.foregroundColor: NSColor.systemBlue], range: range)
            }
            replayToLabel.attributedStringValue = attrs
        }
    }
    
}
