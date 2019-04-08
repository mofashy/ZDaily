//
//  Section.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/2.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class Section: NSObject {
    var desc: String = ""
    var id: Int = 0
    var name: String = ""
    var thumbnail: String = ""
    
    init(_ keyValues: [String: Any]) {
        super.init()
        
        desc = keyValues["description"] as! String
        id = keyValues["id"] as! Int
        name = keyValues["name"] as! String
        thumbnail = keyValues["thumbnail"] as! String
    }
}
