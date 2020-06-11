//
//  LatestStory.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Foundation

struct LatestStory: Decodable {
    var date: String?
    var stories: [Story]?
    var top_stories: [TopStory]?
}
