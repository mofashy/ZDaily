//
//  ZalendarGridView.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/6.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class ZalendarGridView: NSGridView {

    var labels = [NSTextField]()
    
    private var rows = 0
    private var columns = 0
    
    init(rows: Int = 6, columns: Int = 7) {
        super.init(frame: NSRect.zero)
        
        self.rows = rows
        self.columns = columns
        setupLabels(rows*columns)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ZalendarGridView {
    
    func setupLabels(_ count: Int) {
        var leftLabel: NSTextField? = nil
        var topLabel: NSTextField? = nil
        
        for i in 0..<count {
            let label = NSTextField()
            label.isEditable = false
            label.alignment = .center
            label.isBezeled = false
            label.textColor = NSColor.textColor
            label.stringValue = "\(i)"
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            labels.append(label)
            
            NSLayoutConstraint.activate([
                label.leftAnchor.constraint(equalTo: leftLabel?.rightAnchor ?? self.leftAnchor),
                label.topAnchor.constraint(equalTo: topLabel?.bottomAnchor ?? self.topAnchor)
            ])
            if let leftLabel = leftLabel {
                label.widthAnchor.constraint(equalTo: leftLabel.widthAnchor).isActive = true
                label.heightAnchor.constraint(equalTo: leftLabel.heightAnchor).isActive = true
            }
            if let topLabel = topLabel, leftLabel == nil {
                label.widthAnchor.constraint(equalTo: topLabel.widthAnchor).isActive = true
                label.heightAnchor.constraint(equalTo: topLabel.heightAnchor).isActive = true
            }
            if i%columns == columns-1 {
                label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                topLabel = label
                leftLabel = nil
            } else {
                leftLabel = label
            }
            if count-i <= columns {
                label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            }
        }
    }
}
