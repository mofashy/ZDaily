//
//  BeforeRequest.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Foundation
import Alamofire

struct BeforeStoryRequest: RTRequest {
    var date: String
    
    var path: String {
        return "/4/news/before/" + date
    }
    
    var method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var parameters: [String : Any]? = nil
    
    init(_ date: String) {
        self.date = date
    }
}
