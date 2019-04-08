//
//  CommentsViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/4.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class CommentsViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    
    var disapearHandler: (()->Void)?
    
    private var comments: [Comment]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        tableView.backgroundColor = NSColor.clear
        tableView.enclosingScrollView?.drawsBackground = false
        
        guard let headerView = tableView.headerView as? CommentsHeaderView else {
            return
        }
        headerView.closeHandler = { [weak self] ()->Void in self?.dismiss(nil) }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        tableView.scrollRowToVisible(0)
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear()
        
        guard let handler = disapearHandler else { return }
        handler()
    }
    
}


extension CommentsViewController {
    func request(_ id: Int, _ isShort: Bool) {
        let url = isShort ? Apis.Comments.short(id).url : Apis.Comments.long(id).url
        Rocket.request(url, method: .get, params: nil) { [weak self] (result) in
            switch result {
            case .success(let keyValues):
                guard let comments = keyValues["comments"] as? [[String: Any]] else {
                    return
                }
                self?.comments = comments.map({ (item) -> Comment in
                    return Comment(item)
                })
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension CommentsViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return comments?.count ?? 0
    }
}


extension CommentsViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        guard let comment = comments?[row] else { return 0 }
        return comment.height
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard row < comments!.count else { return nil }
        guard let comment = comments?[row] else { return nil }
        
        if comment.reply_to != nil {
            // CommentsCellViewComplex
            guard let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("CommentsCellViewComplex"), owner: self) as? CommentsCellViewComplex else {
                return nil
            }
            view.comment = comment
            return view
        } else {
            // CommentsCellViewSimple
            guard let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("CommentsCellViewSimple"), owner: self) as? CommentsCellViewSimple else {
                return nil
            }
            view.comment = comment
            return view
        }
    }
}
