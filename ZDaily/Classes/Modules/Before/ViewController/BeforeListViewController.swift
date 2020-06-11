//
//  BeforeListViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class BeforeListViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    private lazy var calendarView: CalendarView? = {
        let view = CalendarView.loadFromNib()
        view?.dateChanged = { [unowned self] date in
            self.date = date
            self.request()
        }
        return view
    }()
    
    private var date = ""
    private var beforeStory: BeforeStory?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        date = DU.zdailyDateString(Date())
        _setup()
        request()
    }
        
    private func _setup() {
        tableView.headerView = calendarView
    }
    
    func request() {
        activityIndicator?.startAnimation(nil)
        RT.send(BeforeStoryRequest(date)).parse(BeforeStory.self).done { [unowned self] beforeStory in
            self.beforeStory = beforeStory
            self.tableView.reloadData()
            self.activityIndicator?.stopAnimation(nil)
        }.catch { [unowned self] error in
            self.activityIndicator?.stopAnimation(nil)
            debugPrint(error)
        }
    }
    
}


extension BeforeListViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return beforeStory?.stories?.count ?? 0
    }
}


extension BeforeListViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? BeforeListCellView else { return nil }
        view.story = beforeStory?.stories?[row]
        
        return view
    }
}


extension BeforeListViewController {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow != -1 else { return }
        guard let splitVc = parent as? NSSplitViewController else {
            return
        }
        guard let webVc = splitVc.children.last as? WebViewController else {
            return
        }
        
        guard let story = beforeStory?.stories?[tableView.selectedRow] else { return }
        webVc.load(story)
    }
}
