//
//  Comment.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/4.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class Comment: NSObject {
    
    var author = ""
    var content = ""
    var avatar = ""
    var time: TimeInterval = 0
    var reply_to: Reply_to?
    var id = 0
    var likes = 0
    
    var height: CGFloat = 0
    
    init(_ keyValues: [String: Any]) {
        author = keyValues["author"] as! String
        content = keyValues["content"] as! String
        avatar = keyValues["avatar"] as! String
        time = keyValues["time"] as! TimeInterval
        id = keyValues["id"] as! Int
        likes = keyValues["likes"] as! Int
        
        if let reply_to = keyValues["reply_to"] as? [String: Any] {
            self.reply_to = Reply_to(reply_to)
        }
        
        super.init()
        height = FrameCalc.calcCommentHeight(self)
    }
}


class Reply_to: NSObject {
    
    var content = ""
    var status = 0
    var id = 0
    var author = ""
    var error_msg = ""
    
    init(_ keyValues: [String: Any]) {
        content = keyValues["content"] as? String ?? ""
        status = keyValues["status"] as? Int ?? 0
        id = keyValues["id"] as? Int ?? 0
        author = keyValues["author"] as? String ?? ""
        error_msg = keyValues["error_msg"] as? String ?? ""
    }
}


class FrameCalc: NSObject {
    
    static func calcCommentHeight(_ comment: Comment) -> CGFloat {
        var height: CGFloat = 0
        height += 3
        height += 30
        height += 10
        height += CGFloat(Int((comment.content as NSString).boundingRect(with: CGSize(width: 320-30, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: NSFont.systemFont(ofSize: 13)], context: nil).height)+1)
        
        if let reply_to = comment.reply_to {
            height += 8
            var text = "回复"+reply_to.author+"："+reply_to.content
            if reply_to.status != 0 {
                text = reply_to.error_msg
            }
            height += CGFloat(Int((text as NSString).boundingRect(with: CGSize(width: 320-30, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: NSFont.systemFont(ofSize: 13)], context: nil).size.height)+1)
        }
        
        height += 8+17+10
        return height
    }
}
