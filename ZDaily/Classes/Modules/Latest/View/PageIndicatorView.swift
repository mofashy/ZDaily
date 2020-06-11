//
//  PageIndicatorView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/9.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

@IBDesignable class PageIndicatorView: NSView {
    @IBInspectable var currentPage: Int = 0 {
        didSet {
            self.setNeedsDisplay(bounds)
        }
    }
    @IBInspectable var numberOfPages: Int = 0
    var hidesForSinglePage: Bool = true {
        didSet {
            self.setNeedsDisplay(bounds)
        }
    }
    @IBInspectable var pageIndicatorTintColor: NSColor = .systemGray
    @IBInspectable var currentPageIndicatorTintColor: NSColor = .systemBlue
    
    private var strokeWidth: CGFloat = 6
    private var itemSpacing: CGFloat = 6
    
    public func sizeFor(numberOfPages: Int) -> CGSize {
        return CGSize(width: CGFloat(numberOfPages) * strokeWidth + CGFloat(numberOfPages - 1) * itemSpacing, height: strokeWidth)
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        
        if numberOfPages == 0 || (hidesForSinglePage && numberOfPages == 1) {
            return
        }
        
        var startX: CGFloat = 0
        guard let g = NSGraphicsContext.current else { return }
        let context = g.cgContext
        for i in 0..<numberOfPages {
            startX = (strokeWidth + itemSpacing) * CGFloat(i)
            if i == currentPage {
                context.setFillColor(currentPageIndicatorTintColor.cgColor)
            } else {
                context.setFillColor(pageIndicatorTintColor.cgColor)
            }
            context.fillEllipse(in: CGRect(x: startX, y: (frame.height - strokeWidth) / 2.0, width: strokeWidth, height: strokeWidth))
        }
    }
    
}
