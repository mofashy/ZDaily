//
//  LatestRequest.swift
//  ZDaily
//
//  Created by 沈永聪 on 2020/6/10.
//  Copyright © 2020 mofashy.com. All rights reserved.
//

import Foundation
import Alamofire

struct LatestStoryRequest: RTRequest {
    var path: String {
        return "/4/news/latest"
    }
    
    var method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var parameters: [String : Any]? = nil
}


struct LatestStoryDetailRequest: RTRequest {
    var id: Int
    
    var path: String {
        return "/4/news/\(id)"
    }
    
    var method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var parameters: [String : Any]? = nil
    
    init(_ id: Int) {
        self.id = id
    }
}


struct ShortCommentRequest: RTRequest {
    var id: Int
    
    var path: String {
        return "/4/story/\(id)/short-comments"
    }
    
    var method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var parameters: [String : Any]? = nil
    
    init(_ id: Int) {
        self.id = id
    }
}


struct LongCommentRequest: RTRequest {
    var id: Int
    
    var path: String {
        return "/4/story/\(id)/long-comments"
    }
    
    var method: HTTPMethod = .get
    var headers: HTTPHeaders? = nil
    var parameters: [String : Any]? = nil
    
    init(_ id: Int) {
        self.id = id
    }
}
