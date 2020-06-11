//
//  LatestListViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/9.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class LatestListViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    private var bannerView: LatestBannerView!
    
    var latestStory: LatestStory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        _setup()
        request()
    }
    
    private func _setup() {
        bannerView = LatestBannerView.loadFromNib()
        bannerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width*10.0/16.0)
        tableView.headerView = bannerView
    }
    
    func request() {
        activityIndicator?.startAnimation(nil)
        RT.send(LatestStoryRequest()).parse(LatestStory.self).done { [unowned self] latestStory in
            self.latestStory = latestStory
            self.bannerView.stories = latestStory.top_stories
            self.tableView.reloadData()
            self.activityIndicator?.stopAnimation(nil)
        }.catch { [unowned self] error in
            self.activityIndicator?.stopAnimation(nil)
            debugPrint(error)
        }
    }
    
}


extension LatestListViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return latestStory?.stories?.count ?? 0
    }
}


extension LatestListViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? LatestListCellView else { return nil }
        view.story = latestStory?.stories?[row]
        
        return view
    }
}


extension LatestListViewController {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow != -1 else { return }
        guard let splitVc = parent as? NSSplitViewController else {
            return
        }
        guard let webVc = splitVc.children.last as? WebViewController else {
            return
        }
        
        guard let story = latestStory?.stories?[tableView.selectedRow] else { return }
        webVc.load(story)
    }
}
