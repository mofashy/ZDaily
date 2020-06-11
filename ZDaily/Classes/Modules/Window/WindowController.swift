//
//  WindowController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/9.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {
    
    @IBOutlet weak var segmentedControl: NSSegmentedControl!
    
    private var latestView: LatestSplitViewController!
    private var beforeView: BeforeSplitViewController!
    private var sectionView: SectionSplitViewController!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        segmentedControl.selectedSegment = 0
        latestView = contentViewController as? LatestSplitViewController
    }

    @IBAction func segmentedControlAction(_ sender: NSSegmentedControl) {
        switch sender.selectedSegment {
        case 0:
            loadLatestView()
        case 1:
            loadBeforeView()
        default:
            loadSectionView()
            break
        }
    }
}


extension WindowController {
    
    func loadLatestView() {
        if latestView == nil {
            latestView = NSStoryboard(name: "Latest", bundle: nil).instantiateInitialController() as? LatestSplitViewController
        }
        window?.contentViewController = latestView
    }
    
    func loadBeforeView() {
        if beforeView == nil {
            beforeView = NSStoryboard(name: "Before", bundle: nil).instantiateInitialController() as? BeforeSplitViewController
        }
        window?.contentViewController = beforeView
    }
    
    func loadSectionView() {
        if sectionView == nil {
            sectionView = NSStoryboard(name: "Section", bundle: nil).instantiateInitialController() as? SectionSplitViewController
        }
        window?.contentViewController = sectionView
    }
}
