//
//  Rocket.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/2.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa
import Alamofire
import PromiseKit

protocol RTRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: [String: Any]? { get }
}


let RT = Rocket.shared

class Rocket: NSObject {

    static let shared = Rocket()
    private var base_url = "https://news-at.zhihu.com/api"
    private var token = ""
    
    private override init() {
        
    }
    
    func send<T>(_ r: T) -> PromiseKit.Promise<DataRequest> where T : RTRequest {
        return Promise { seal in
            seal.fulfill(AF.request(base_url + r.path, method: r.method, parameters: r.parameters, encoding: URLEncoding.default, headers: r.headers, interceptor: nil, requestModifier: nil))
        }
    }
    
}


extension Alamofire.DataRequest {
    
    func response() -> PromiseKit.Promise<Any> {
        return Promise { seal in
            self.responseJSON(completionHandler: { (response) in
                if let error = response.error {
                    seal.reject(error)
                    return
                }
                
                guard let data = response.data else {
                    seal.reject(NSError(domain: "NTURLRequestError", code: -1, userInfo: [NSLocalizedDescriptionKey: "数据接收失败"]))
                    return
                }
                
                seal.fulfill(data)
            })
        }
    }
    
    func response<H: Decodable>(_ type: H.Type) -> PromiseKit.Promise<H> {
        return response().then { (data) -> Promise<H> in
            return Promise { seal in
                do {
                    let model = try JSONDecoder().decode(type.self, from: data as! Data)
                    seal.fulfill(model)
                } catch {
                    seal.reject(error)
                }
            }
        }
    }
    
}


extension Promise where T : Alamofire.DataRequest {
    
    func parse<H: Decodable>(_ type: H.Type) -> PromiseKit.Promise<H> {
        return self.then { (request) -> Promise<H> in
            return request.response(type)
        }
    }
    
}
