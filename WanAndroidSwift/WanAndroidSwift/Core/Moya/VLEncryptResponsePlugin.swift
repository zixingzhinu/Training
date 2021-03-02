//
//  VLEncryptResponsePlugin.swift
//  EasyMoney
//
//  Created by James on 2020/5/22.
//  Copyright © 2020 普惠. All rights reserved.
//  重新定义加密的响应插件

import Foundation
import Moya
import SwiftyJSON

struct VLEncryptResponsePlugin: PluginType {
    func process(_ result: Swift.Result<Response, MoyaError>, target: VLTargetType) -> Swift.Result<Response, MoyaError> {
        switch result {
        case .success(let response):
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }
}
