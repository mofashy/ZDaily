//
//  LatestNews.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/3.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class LatestStories: NSObject {
    
    var date = ""
    var stories: [LatestStory]!
    var top_stories: [LatestStory]!
    
    init(_ keyValues: [String: Any]) {
        date = keyValues["date"] as! String
        
        let stories = keyValues["stories"] as! [[String: Any]]
        self.stories = stories.map({ (item) -> LatestStory in
            return LatestStory(item)
        })
        
        let top_stories = keyValues["top_stories"] as! [[String: Any]]
        self.top_stories = top_stories.map({ (item) -> LatestStory in
            return LatestStory(item)
        })
    }
}
