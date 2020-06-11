//
//  PagingScrollView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

//TODO: 分页
class PagingScrollView: NSScrollView {
    
    lazy var timer: Timer = {
        let timer = Timer(timeInterval: 3.0, target: self, selector: #selector(fireAction), userInfo: nil, repeats: true)
        timer.fireDate = Date(timeInterval: 3.0, since: Date())
        RunLoop.current.add(timer, forMode: .common)
        return timer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        timer.fire()
    }
    
    @objc func fireAction() {
        scrollToPosition(CGPoint(x: documentVisibleRect.minX + frame.width, y: 0))
    }
}


extension PagingScrollView {
    
    func scrollToPosition(_ position: CGPoint){
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 0.4
        NSAnimationContext.current.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        contentView.animator().setBoundsOrigin(position)
        reflectScrolledClipView(contentView)
        NSAnimationContext.endGrouping()
    }
    
}
