//
//  Section.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Foundation

struct Section: Decodable {
    var id: Int
    var name: String?
    var thumbnail: String?
    var description: String?
}


struct SectionData: Decodable {
    var data: [Section]?
}
