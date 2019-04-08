//
//  Apis.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/2.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa

class Apis: NSObject {
    fileprivate static let base = "https://news-at.zhihu.com/api"
}


extension Apis {
    enum News {
        case latest
        case detail(Int)
        case before(String)

        var url: String {
            switch self {
            case .latest:
                return Apis.base+"/4/news/latest"
            case .detail(let id):
                return Apis.base+"/4/news/\(id)"
            case .before(let date):
                return Apis.base+"/4/news/before/\(date)"
            }
        }
    }
}


extension Apis {
    enum Section {
        case list
        case detail(Int)
        
        var url: String {
            switch self {
            case .list:
                return Apis.base+"/3/sections"
            case .detail(let id):
                return Apis.base+"/3/section/\(id)"
            }
        }
    }
}


extension Apis {
    enum Comments {
        case short(Int)
        case long(Int)
        
        var url: String {
            switch self {
            case .short(let id):
                return Apis.base+"/4/story/\(id)/short-comments"
            case .long(let id):
                return Apis.base+"/4/story/\(id)/long-comments"
            }
        }
    }
}
