//
//  SectionDetail.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Foundation

struct SectionDetail: Decodable {
    var name: String?
    var timestamp: Int = 0
    var stories: [SectionStory]?
}
