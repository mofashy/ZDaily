//
//  SectionListViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class SectionListViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    
    private var sectionData: SectionData?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        request()
    }
    
    func request() {
        activityIndicator?.startAnimation(nil)
        RT.send(SectionListRequest()).parse(SectionData.self).done { [unowned self] sectionData in
            self.sectionData = sectionData
            self.tableView.reloadData()
            self.activityIndicator?.stopAnimation(nil)
            self.loadSectionDetail(sectionData.data?.first)
        }.catch { [unowned self] error in
            self.activityIndicator?.stopAnimation(nil)
            debugPrint(error)
        }
    }
    
}


extension SectionListViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return sectionData?.data?.count ?? 0
    }
}


extension SectionListViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? SectionListCellView else { return nil }
        view.section = sectionData?.data?[row]
        
        return view
    }
}


extension SectionListViewController {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow != -1 else { return }
        loadSectionDetail(sectionData?.data?[tableView.selectedRow])
    }
    
    func loadSectionDetail(_ section: Section?) {
        guard let splitVc = parent as? NSSplitViewController else {
            return
        }
        guard let sectionDetailVc = splitVc.children[1] as? SectionDetailViewController else {
            return
        }
        sectionDetailVc.section = section
    }
}
