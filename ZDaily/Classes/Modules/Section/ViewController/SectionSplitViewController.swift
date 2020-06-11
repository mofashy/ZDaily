//
//  SectionSplitViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class SectionSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        for i in 0..<splitViewItems.count {
            let splitViewItem = splitViewItems[i]
            if i == 0 {
                splitViewItem.minimumThickness = 142
                splitViewItem.maximumThickness = 210
            } else if i == 1 {
                splitViewItem.minimumThickness = 290
                splitViewItem.maximumThickness = 290
            }
        }
    }
    
}
