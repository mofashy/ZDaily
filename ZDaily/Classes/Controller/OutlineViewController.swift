//
//  OutlineViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/2.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class OutlineViewController: NSViewController {

    @IBOutlet weak var latestButton: NSButton!
    @IBOutlet weak var beforeButton: NSButton!
    @IBOutlet weak var sectionButton: NSButton!
    private var selectedBtn: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        selectedBtn = latestButton
    }
    
    
    private func switchState(_ sender: NSButton) {
        selectedBtn.switchState(.normal)
        sender.switchState(.selected)
        selectedBtn = sender
    }
    
    
    private func request(_ type: ZDailyType) {
        guard let splitVc = parent as? NSSplitViewController else {
            return
        }
        guard let storiesVc = splitVc.children.last as? StoriesViewController else {
            return
        }
        storiesVc.`switch`(type)
        storiesVc.request(type)
    }
    
    @IBAction func latestAction(_ sender: NSButton) {
        switchState(sender)
        request(.latest)
    }
    
    @IBAction func beforeAction(_ sender: NSButton) {
        switchState(sender)
        request(.before)
    }
    
    @IBAction func sectionAction(_ sender: NSButton) {
        switchState(sender)
        request(.section)
    }
    
}
