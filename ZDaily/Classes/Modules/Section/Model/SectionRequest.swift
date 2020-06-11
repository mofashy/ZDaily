//
//  SectionRequest.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Foundation
import Alamofire

struct SectionListRequest: RTRequest {
    var path: String {
        return "/3/sections"
    }
    
    var method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var parameters: [String : Any]? = nil
}


struct SectionDetailRequest: RTRequest {
    var id: Int
    
    var path: String {
        return "/3/section/\(id)"
    }
    
    var method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var parameters: [String : Any]? = nil
    
    init(_ id: Int) {
        self.id = id
    }
}
