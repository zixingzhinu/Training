//
//  NetworkKit.swift
//  HelloDouyu
//
//  Created by James on 2019/1/21.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit
import Alamofire


class NetworkKit: NSObject {

    class func requestData(url: String, method: HTTPMethod = .post, params: [String: Any]? = nil, headers: HTTPHeaders? = nil, completion: @escaping (_ result: Any) -> ()) {
        print("==url地址：\(url)，params：\(String(describing: params))")
        Alamofire.request(url, method: method, parameters: params, headers: headers).validate(contentType: ["text/plain"]).responseJSON { (response:DataResponse<Any>) in
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
//            guard let data = response.data else {
//                return
//            }
//            let utf8Text = String(data: data, encoding: .utf8)
//            print("==" + (utf8Text ?? "编码错误"))
            print("==\(result)")
            completion(result)
        }
        
    }
}
