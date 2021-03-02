//
//  VLMoyaLogPlugin.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/15.
//  Copyright © 2020 FinupCredit. All rights reserved.
//  自定义Log Plugin，可以不使用，不能继续扩展

import UIKit
import Moya

final class VLMoyaLogPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        print("\n-------------------\n准备请求: \(target.path)")
        print("请求方式: \(target.method.rawValue)")
        if let params = (target as? VLTargetType)?.parameters {
            print(params)
        }
        print("\n")
    }
    
    func didReceive(_ result: Swift.Result<Response, MoyaError>, target: TargetType) {
        print("\n-------------------\n请求结束: \(target.path)")
        switch result {
        case .success(let response):
            if let string = String(data: response.data, encoding: String.Encoding.utf8) {
                print("请求结果: \(string)")
            }
            else {
                print("请求结果为空")
            }
        case .failure(let moyaError):
            print("请求失败，错误信息：" + (moyaError.errorDescription ?? "---"))
        }
        print("\n")
    }
}
