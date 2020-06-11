//
//  StoryDetail.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Foundation

struct StoryDetail: Decodable {
    var id: Int
    var js: [String]?
    var css: [String]?
    var url: String?
    var type: Int
    var body: String?
    var title: String?
    var image: String?
    var images: [String]?
    var section: Section?
    var ga_prefix: String?
    var share_url: String?
    var image_hue: String?
}
