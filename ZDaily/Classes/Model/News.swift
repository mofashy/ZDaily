//
//  News.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/3.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class News: NSObject {
    
    var body = ""
    var image_source = ""
    var title = ""
    var image = ""
    var share_url = ""
    var js: [String]!
    var ga_prefix = ""
    var images: [String]!
    var type = 0
    var id = 0
    var css: [String]!
    
    init(_ keyValues: [String: Any]) {
        super.init()
        
        body = keyValues["body"] as! String
        image_source = keyValues["image_source"] as! String
        title = keyValues["title"] as! String
        image = keyValues["image"] as! String
        share_url = keyValues["share_url"] as! String
        js = keyValues["js"] as? [String]
        ga_prefix = keyValues["ga_prefix"] as! String
        images = keyValues["images"] as? [String]
        type = keyValues["type"] as! Int
        id = keyValues["id"] as! Int
        css = keyValues["css"] as? [String]
    }
}
