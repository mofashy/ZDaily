//
//  SectionStories.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/3.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class SectionStories: NSObject {
    
    var name = ""
    var timestamp = ""
    var stories: [SectionStory]!
    
    init(_ keyValues: [String: Any]) {
        name = keyValues["name"] as! String
        
        let stories = keyValues["stories"] as! [[String: Any]]
        self.stories = stories.map({ (item) -> SectionStory in
            return SectionStory(item)
        })
    }
}
