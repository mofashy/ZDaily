//
//  StoriesViewController.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/3.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa
import Kingfisher

enum ZDailyType {
    case latest
    case before
    case section
}

class StoriesViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    private var before = ""
    private var stories = [Story]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        request(.latest)
    }
    
    func `switch`(_ type: ZDailyType) {
        switch type {
        case .latest:
            tableView.headerView = nil
        case .before:
            before = SingleDateFormatter.shared.zdailyDateString(Date())
            tableView.headerView = BeforeHeaderView(frame: NSRect(x: 0, y: 0, width: 260, height: 213))
        case .section:
            break
        }
    }
    
    func request(_ type: ZDailyType) {
        var url = Apis.News.latest.url
        if type == .before {
            url = Apis.News.before(before).url
        } else if type == .section {
            url = Apis.News.detail(1).url
        }
        Rocket.request(url, method: .get, params: nil) { [weak self] (result) in
            switch result {
            case .success(let keyValues):
                switch type {
                case .latest:
                    self?.stories = LatestStories(keyValues).stories
                case .before:break
                case .section:
                    self?.stories = SectionStories(keyValues).stories
                }
                self?.tableView.reloadData()
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
}


extension StoriesViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return stories.count
    }
    
}


extension StoriesViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let view = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("StoriesCell"), owner: self) as? StoriesCellView else { return nil }
        let story = stories[row]
        view.titleLabel.stringValue = story.title
        if let story = story as? SectionStory {
            view.truncatedTextLabel.stringValue = story.display_date
        } else {
            view.truncatedTextLabel.stringValue = ""
        }
        
        if let url = story.images.first {
            let processor = DownsamplingImageProcessor(size: CGSize(width: 50, height: 50))
            view.coverView.kf.setImage(
                with: URL(string: url),
                placeholder: nil,
                options: [
                    .processor(processor),
                    .scaleFactor(NSScreen.main!.backingScaleFactor),
                    .transition(.none),
                    .cacheOriginalImage
                ])
        }
        
        return view
    }
    
}

extension StoriesViewController {
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow != -1 else { return }
        guard let splitVc = parent?.parent as? NSSplitViewController else {
            return
        }
        guard let webVc = splitVc.children.last as? WebViewController else {
            return
        }
        
        let section = stories[tableView.selectedRow]
        webVc.request(section.id)
    }
    
}
