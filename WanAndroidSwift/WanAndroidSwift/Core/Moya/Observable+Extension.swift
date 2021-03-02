//
//  Observable+Extension.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/15.
//  Copyright © 2020 FinupCredit. All rights reserved.
//  扩展Observable，处理响应

import UIKit
import Moya
import RxSwift
import SwiftyJSON
import HandyJSON


extension Observable where Element: Response {
    
    /// 过滤网络错误
    func filterNetError() -> Observable<Element> {
        return filter { (response) -> Bool in
            if 200...209 ~= response.statusCode {
                return true
            }
            printDebug("网络错误")
            throw NetError.error("网络错误")
        }
    }
    
    /// 过滤响应错误
    func filterResponseError() -> Observable<JSON> {
        return filterNetError().map { (response) -> JSON in
            let json = try JSON(data: response.data)
            var code = VLNetStatusCode.StatusCode_200.rawValue
            if let codeStr = json["code"].rawString(), let c = Int(codeStr) {
                code = c
            }
            let msg = self.handleMessage(json)
            var success: Bool = false
            if let succ = json["success"].bool {
                success = succ
            }
            debugPrint("code:", code, "success:", success, "msg:", msg, Thread.current, Thread.current.name!, Thread.current.isMainThread)
            if code == VLNetStatusCode.StatusCode_200.rawValue {
                return json
            }
            
            throw self.handleError(code, msg)
        }
    }
    
    /// 捕获并处理消息
    /// - Parameters:
    ///   - json: json
    ///   - msg: 消息
    fileprivate func handleMessage(_ json: JSON) -> String {
        var msg = ""
        if json["message"].exists() {
            msg = json["message"].stringValue
        }
        else if json["msg"].exists() {
            msg = json["msg"].stringValue
        }
        return msg
    }
    
    /// 处理错误
    /// - Parameters:
    ///   - code: 状态码
    ///   - msg: 响应消息
    fileprivate func handleError(_ code: Int, _ msg: String) -> NetError {
        switch code {
        case VLNetStatusCode.StatusCode_401.rawValue:
            return NetError.unAuthorized(msg)
        case VLNetStatusCode.StatusCode_11114.rawValue:
            return NetError.loginStatusInvalid(msg)
        default: return NetError.error(msg)
        }
    }
    
    /// 处理响应结果
    func handleResponse() -> Observable<Data> {
        return filterResponseError().map { (json) -> Data in
            var result: Data
            if json["value"].exists() {
                result = try json["value"].rawData()
            }
            else if json["result"].exists() {
                result = try json["result"].rawData()
            }
            else if json["data"].exists() {
                result = try json["data"].rawData()
            }
            else {
                result = Data()
            }
            return result
        }
    }
    
    /// 处理json，可以在这里处理json解析的错误，也可以抛出去处理
    func handleJSON<M: Decodable>(_ type: M.Type) -> Observable<M> {
        return handleResponse().map { (data) -> M in
            do {
                let model: M = try JSONDecoder().decode(M.self, from: data)
                return model
            } catch let DecodingError.typeMismatch(type, context) {
                throw NetError.jsonError("The Type is not match, type is: \(type), description: \(context.debugDescription)")
            } catch let DecodingError.valueNotFound(type, context) {
                throw NetError.jsonError("The value is not found, type is: \(type), description: \(context.debugDescription)")
            } catch let DecodingError.keyNotFound(codingKey, context) {
                throw NetError.jsonError("The key is not found, codingKey is: \(codingKey), description: \(context.debugDescription)")
            } catch let DecodingError.dataCorrupted(context) {
                throw NetError.jsonError("The data is corrupted, description: \(context.debugDescription)")
            } catch {
                throw NetError.error("json serialization error")
            }
        }
    }
    
}
