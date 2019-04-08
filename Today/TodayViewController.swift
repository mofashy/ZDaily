//
//  TodayViewController.swift
//  Today
//
//  Created by 沈永聪 on 2019/4/3.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding {

    @IBOutlet weak var tableView: NSTableView!
    
    private var feed: [[String: Any]]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override var nibName: NSNib.Name? {
        return NSNib.Name("TodayViewController")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        preferredContentSize = CGSize(width: view.frame.width, height: 160)
        
        // NSTableView清除背景色
        tableView.backgroundColor = NSColor.clear
        tableView.enclosingScrollView?.drawsBackground = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        tableView.dataSource = self
        tableView.delegate = self
        
        request("https://news-at.zhihu.com/api/4/news/latest") { [weak self] (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    if let keyValues = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        if let feed = keyValues["stories"] as? [[String: Any]] {
                            self?.feed = feed
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        completionHandler(.noData)
    }

}


extension TodayViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return feed?.count ?? 0
    }
    
}


extension TodayViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("TodayCellView"), owner: self) as? NSTableCellView else {
            return nil
        }
        guard let feed = feed else {
            return nil
        }
        
        guard row < feed.count else {
            return nil
        }
        
        view.textField?.stringValue = feed[row]["title"] as! String
        return view
    }
}


extension TodayViewController {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow != -1 else { return }
        
        let id = feed?[tableView.selectedRow]["id"]
        let url = URL(string: "ZDailyTodayExtension://latest/\(id!)")!
        NSWorkspace.shared.open(url)
    }
}


extension TodayViewController {
    
    enum HTTPResult {
        case success(Data?)
        case failure(Error)
    }
    
    func request(_ urlString: String?, _ completionHandler: @escaping (HTTPResult)->Void) {
        guard let urlString = urlString else {
            fatalError("Require url string")
        }
        
        guard let url = URL(string: urlString)  else {
            fatalError("Invalid url")
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(.failure(error))
                } else {
                    completionHandler(.success(data))
                }
            }
        }
        task.resume()
    }
}
