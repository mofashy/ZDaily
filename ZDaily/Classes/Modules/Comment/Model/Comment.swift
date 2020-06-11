//
//  Comment.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Foundation

struct Comment: Decodable {
    var id: Int
    var time: Int
    var likes: Int
    var avatar: String?
    var author: String?
    var content: String?
}


struct CommentData: Decodable {
    var comments: [Comment]?
}
