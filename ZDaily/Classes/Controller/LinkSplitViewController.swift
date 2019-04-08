//
//  LinkSplitViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/2.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class LinkSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        splitViewItems.first!.minimumThickness = 70
        splitViewItems.first!.maximumThickness = 70
        
        splitViewItems.last!.minimumThickness = 260
        splitViewItems.last!.maximumThickness = 260
    }
    
}
