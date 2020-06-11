//
//  SectionDetailViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class SectionDetailViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    
    var section: Section? {
        didSet {
            request()
        }
    }
    private var sectionDetail: SectionDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func request() {
        guard let s = section else { return }
        activityIndicator?.startAnimation(nil)
        RT.send(SectionDetailRequest(s.id)).parse(SectionDetail.self).done { [unowned self] sectionDetail in
            self.sectionDetail = sectionDetail
            self.tableView.reloadData()
            self.activityIndicator?.stopAnimation(nil)
        }.catch { [unowned self] error in
            self.activityIndicator?.stopAnimation(nil)
            debugPrint(error)
        }
    }
    
}


extension SectionDetailViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return sectionDetail?.stories?.count ?? 0
    }
}


extension SectionDetailViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? SectionDetailCellView else { return nil }
        view.story = sectionDetail?.stories?[row]
        
        return view
    }
}


extension SectionDetailViewController {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow != -1 else { return }
        guard let splitVc = parent as? NSSplitViewController else {
            return
        }
        guard let webVc = splitVc.children.last as? WebViewController else {
            return
        }
        
        guard let story = sectionDetail?.stories?[tableView.selectedRow] else { return }
        webVc.load(story)
    }
}
