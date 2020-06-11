//
//  CommentListViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Cocoa

class CommentListViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    var id = 0
    private var commentData: CommentData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        tableView.usesAutomaticRowHeights = true
        request()
    }
    
    func request() {
        activityIndicator?.startAnimation(nil)
        RT.send(LongCommentRequest(id)).parse(CommentData.self).done { [unowned self] commentData in
            self.commentData = commentData
            self.tableView.reloadData()
            self.activityIndicator?.stopAnimation(nil)
        }.catch { [unowned self] error in
            self.activityIndicator?.stopAnimation(nil)
            debugPrint(error)
        }
    }
    
    @IBAction func popAction(_ sender: Any) {
        dismiss(self)
    }
}


extension CommentListViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return commentData?.comments?.count ?? 0
    }
}


extension CommentListViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? CommentListCellView else {
            return nil
        }
        view.comment = commentData?.comments?[row]
        
        return view
    }
}
