//
//  Story.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Foundation

protocol ZDStory {
    var id: Int { get set }
    var url: String? { get set }
    var title: String? { get set }
    var image_hue: String? { get set }
}

struct Story: Decodable, ZDStory {
    var id: Int
    var url: String?
    var type: Int
    var hint: String?
    var title: String?
    var images: [String]?
    var ga_prefix: String?
    var image_hue: String?
}


struct TopStory: Decodable, ZDStory {
    var id: Int
    var url: String?
    var type: Int
    var hint: String?
    var title: String?
    var image: String?
    var ga_prefix: String?
    var image_hue: String?
}


struct SectionStory: Decodable, ZDStory {
    var id: Int
    var url: String?
    var date: String?
    var title: String?
    var images: [String]?
    var display_date: String?
    var image_hue: String?
}
