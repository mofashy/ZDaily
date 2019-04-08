//
//  Rocket.swift
//  ZDaily
//
//  Created by 沈永聪 on 2019/4/2.
//  Copyright © 2019 mofashy.com. All rights reserved.
//

import Cocoa
import Alamofire

class Rocket: NSObject {
    enum HTTPResult {
        case success([String: Any])
        case failure(Error)
    }
    
    class func request(_ url: String, method: HTTPMethod, params: Dictionary<String, Any>?, completionHandler: @escaping (HTTPResult) -> Void) -> Void {
        Alamofire.request(url, method: method, parameters: params).response { response in
            if let error = response.error {
                return completionHandler(.failure(error))
            } else {
                let res = try! JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! [String: Any]
                completionHandler(.success(res))
            }
        }
    }
}
