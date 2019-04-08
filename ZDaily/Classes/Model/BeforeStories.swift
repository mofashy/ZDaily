//
//  BeforeStories.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/3.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class BeforeStories: NSObject {

    var date = ""
    var stories: [LatestStory]!
    
    init(_ keyValues: [String: Any]) {
        date = keyValues["date"] as! String
        
        let stories = keyValues["stories"] as! [[String: Any]]
        self.stories = stories.map({ (item) -> LatestStory in
            return LatestStory(item)
        })
    }
}
