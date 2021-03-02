//
//  NetwokManager.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/15.
//  Copyright © 2020 FinupCredit. All rights reserved.
//  网络管理类

import UIKit
import Moya
import RxSwift


/// 网络管理
struct NetworkManager<T: VLTargetType> {
    
    /// 定义请求，直接返回result结果
    /// - Parameters:
    ///   - targetType: 自定义的TargetType
    ///   - success: 响应成功
    ///   - failure: 响应失败
    ///   - completion: 完成的闭包
    ///   - disposed: disposed
    static func request(targetType: T,
                                      success: ((Data) -> Void)? = nil,
                                      failure: ((Error) -> Void)? = nil,
                                      completion:(() -> Void)? = nil,
                                      disposed: (() -> Void)? = nil) {
        _ = T.provider.requestAPI(targetType)
            .handleResponse()
            .subscribe(onNext: { (result) in
                guard let success = success else { return }
                success(result)
            }, onError: { (error) in
                guard let failure = failure else { return }
                failure(error)
            }, onCompleted: {
                guard let completion = completion else { return }
                completion()
            }) {
                guard let disposed = disposed else { return }
                disposed()
        };
    }
    
    /// 定义请求，直接返回result结果
    /// - Parameters:
    ///   - targetType: 自定义的TargetType
    ///   - success: 响应成功
    ///   - failure: 响应失败
    ///   - completion: 完成的闭包
    ///   - disposed: disposed
    static func requestJSON<M: Decodable>(targetType: T,
                                      _ modelType: M.Type,
                                      success: ((M) -> Void)? = nil,
                                      failure: ((Error) -> Void)? = nil,
                                      completion:(() -> Void)? = nil,
                                      disposed: (() -> Void)? = nil) {
        _ = T.provider.requestAPI(targetType)
            .handleJSON(modelType)
            .subscribe(onNext: { (result) in
                guard let success = success else { return }
                success(result)
            }, onError: { (error) in
                guard let failure = failure else { return }
                failure(error)
            }, onCompleted: {
                guard let completion = completion else { return }
                completion()
            }) {
                guard let disposed = disposed else { return }
                disposed()
        };
    }
}


// MARK: - Reactive扩展
/// 为Reactive扩展方法
extension Reactive where Base: MoyaProviderType {
    func requestAPI(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<Response> {
        return self.request(token, callbackQueue: callbackQueue).asObservable()
    }
}


