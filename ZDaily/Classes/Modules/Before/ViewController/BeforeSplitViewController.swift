//
//  BeforeSplitViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class BeforeSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        if let firstItem = splitViewItems.first {
            firstItem.minimumThickness = 290
            firstItem.maximumThickness = 290
        }
    }
    
}
