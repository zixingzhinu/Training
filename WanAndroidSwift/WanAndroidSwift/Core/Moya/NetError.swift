//
//  NetError.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/15.
//  Copyright © 2020 FinupCredit. All rights reserved.
//  请求错误定义

import UIKit


/// 网络错误定义
public enum NetError: Error {
    // 自定义错误
    case error(String)
    // 请求未认证(token无效)
    case unAuthorized(String)
    // 登录状态无效
    case loginStatusInvalid(String)
    // 服务器返回错误
    case serverError(String, Int)
    // json错误
    case jsonError(String)
}

extension NetError {
    var code: Int {
        switch self {
        case let .serverError(_, code):
            return code
        default:
            return -1
        }
    }
    
    var message: String? {
        switch self {
        case .error(let msg):
            return msg
        case .unAuthorized(let msg):
            return msg
        case .loginStatusInvalid(let msg):
            return msg
        case .serverError(let msg, _):
            return msg
        case .jsonError(let msg):
            return msg
        }
    }
    
    
}

extension Error {
    func rawString() -> String {
        guard let err = self as? NetError else { return localizedDescription }
        switch err {
        case .error(let msg):
            return msg
        case .unAuthorized(let msg):
            return msg
        case .loginStatusInvalid(let msg):
            return msg
        case .serverError(let msg, _):
            return msg
        case .jsonError(let msg):
            return msg
        }
    }
}
