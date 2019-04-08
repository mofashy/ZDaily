//
//  ZalendarView+Stack.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/6.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

extension ZalendarView {
    
    func addStack() {
        addSubview(headView)
        
        addSubview(scrollView)
        scrollView.contentView = clipView
        clipView.documentView = childView
        childView.addSubview(pageView1)
        childView.addSubview(pageView2)
        childView.addSubview(pageView3)
    }
    
    func buildHead() {
        let weekDayArray = ["日", "一", "二", "三" ,"四", "五", "六"]
        var leftLabel: NSTextField? = nil
        for i in 0..<weekDayArray.count {
            let label = NSTextField()
            label.isEditable = false
            label.alignment = .center
            label.isBezeled = false
            label.textColor = NSColor.textColor
            label.stringValue = weekDayArray[i]
            label.translatesAutoresizingMaskIntoConstraints = false
            headView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.leftAnchor.constraint(equalTo: leftLabel?.rightAnchor ?? headView.leftAnchor),
                label.topAnchor.constraint(equalTo: headView.topAnchor),
                label.bottomAnchor.constraint(equalTo: headView.bottomAnchor)
            ])
            if let leftLabel = leftLabel {
                label.widthAnchor.constraint(equalTo: leftLabel.widthAnchor).isActive = true
            }
            if i == weekDayArray.count-1 {
                label.rightAnchor.constraint(equalTo: headView.rightAnchor).isActive = true
            }
            leftLabel = label
        }
        leftLabel = nil
    }
    
    func layoutStack() {
        NSLayoutConstraint.activate([
            // Constraints headView
            headView.leftAnchor.constraint(equalTo: self.leftAnchor),
            headView.rightAnchor.constraint(equalTo: self.rightAnchor),
            headView.topAnchor.constraint(equalTo: self.topAnchor, constant: 38),
            headView.heightAnchor.constraint(equalToConstant: 25),
            
            // Constraints scrollView
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: headView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Constraints clipView
            clipView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            clipView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            clipView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            clipView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // Constraints childView
            childView.leftAnchor.constraint(equalTo: clipView.leftAnchor),
            childView.widthAnchor.constraint(equalToConstant: frame.width*3),
            childView.topAnchor.constraint(equalTo: clipView.topAnchor),
            childView.bottomAnchor.constraint(equalTo: clipView.bottomAnchor),
            
            // Constraints pageView1
            pageView1.leftAnchor.constraint(equalTo: childView.leftAnchor),
            pageView1.topAnchor.constraint(equalTo: childView.topAnchor),
            pageView1.bottomAnchor.constraint(equalTo: childView.bottomAnchor),
            pageView1.widthAnchor.constraint(equalTo: clipView.widthAnchor),
            
            // Constraints pageView2
            pageView2.leftAnchor.constraint(equalTo: pageView1.rightAnchor),
            pageView2.topAnchor.constraint(equalTo: childView.topAnchor),
            pageView2.bottomAnchor.constraint(equalTo: childView.bottomAnchor),
            pageView2.widthAnchor.constraint(equalTo: clipView.widthAnchor),
            
            // Constraints pageView3
            pageView3.leftAnchor.constraint(equalTo: pageView2.rightAnchor),
            pageView3.topAnchor.constraint(equalTo: childView.topAnchor),
            pageView3.bottomAnchor.constraint(equalTo: childView.bottomAnchor),
            pageView3.widthAnchor.constraint(equalTo: clipView.widthAnchor)
        ])
    }
    
}
