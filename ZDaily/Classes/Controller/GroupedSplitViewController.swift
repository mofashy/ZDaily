//
//  GroupedSplitViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/2.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class GroupedSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        splitViewItems.first!.minimumThickness = 331
        splitViewItems.first!.maximumThickness = 331
        
        splitViewItems.last!.minimumThickness = 648
//        splitViewItems.last!.maximumThickness = 648
    }
    
}
