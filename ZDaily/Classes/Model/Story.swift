//
//  Shows.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/3.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class Story: NSObject {

    var images: [String]!
    var id = 0
    var title = ""
    
    init(_ keyValues: [String: Any]) {
        super.init()
        
        images = keyValues["images"] as? [String]
        id = keyValues["id"] as! Int
        title = keyValues["title"] as! String
    }
}


class LatestStory: Story {
    
    var type = 0
    var ga_prefix = ""
    var multipic = false
    
    override init(_ keyValues: [String: Any]) {
        super.init(keyValues)
        
        images = keyValues["images"] as? [String]
        type = keyValues["type"] as! Int
        ga_prefix = keyValues["ga_prefix"] as! String
        if keyValues.keys.contains("multipic") {
            multipic = keyValues["multipic"] as! Bool
        }
    }
}


class SectionStory: Story {
    
    var date = ""
    var display_date = ""
    
    override init(_ keyValues: [String: Any]) {
        super.init(keyValues)
        
        date = keyValues["date"] as! String
        display_date = keyValues["display_date"] as! String
    }
}
