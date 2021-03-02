//
//  VLTargetType.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/8.
//  Copyright © 2020 FinupCredit. All rights reserved.
//  自定义TargetType

import UIKit
import Moya
import RxSwift

// 全局的Provider集合
fileprivate var retainProviders: [String: Any] = [:]

// MARK: - 扩展TargetType协议
/// 为TargetType添加功能
protocol VLTargetType: TargetType {
    var parameters: [String: Any]? { get }
}

// MARK: - VLTargetType扩展
extension VLTargetType {
    
    // MARK: - Public Readonly Computed properties
    var headers: [String : String]? {
        var headers: [String: String] = [:]
        return headers
    }
    
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        ""
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Task {
        requestTaskWithParameters
    }
    
    var requestTaskWithParameters: Task {
        // 设置默认参数
        var defaultParams: [String: Any] = [:]
        // 设置自定义参数
        if let params = self.parameters {
            for (key, value) in params {
                defaultParams[key] = value
            }
        }
        return .requestParameters(parameters: defaultParams, encoding: parameterEncoding)
    }
    
    var parameterEncoding: ParameterEncoding {
        URLEncoding.default
    }
    
    var sampleData: Data {
        Data()
    }
    
    var validationType: ValidationType {
        .none
    }
    
    static var networkActivityPlugin: PluginType {
        NetworkActivityPlugin { (changeType, target) in
            switch changeType {
            case .began:
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            case .ended:
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    static var provider: Reactive<MoyaProvider<Self>> {
        let key = "\(Self.self)"
        if let provider = retainProviders[key] as? Reactive<MoyaProvider<Self>> {
            return provider
        }
        let provider = self.weakProvider
        retainProviders[key] = provider
        return provider
    }
    
    static var weakProvider: Reactive<MoyaProvider<Self>> {
        var plugins:[PluginType] = [networkActivityPlugin]
        #if DEBUG
        plugins.append(NetworkLoggerPlugin())
        #endif
        // 加入响应加解密插件
        plugins.append(VLEncryptResponsePlugin())
        let provider = MoyaProvider<Self>(session: session, plugins: plugins)
//        let provider = MoyaProvider<Self>(endpointClosure: myEndpointMapping, manager: sessionManager, plugins: plugins)
        return provider.rx
    }
    
    static var session: Session {
        // config
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeoutIntervalForRequest
        return Session(configuration: config)
    }
    
    static func myEndpointMapping(for target: Self) -> Endpoint {
        return Endpoint(
            //"?"不是path一部分。 它是path和query之间的分隔符。
            // 如果你试图添加"?"到path，它必须是URL编码，因为"?"不是路径组件的有效字符。
            // 最好的解决方案是从path放弃"?"， 因为它没有任何意义。
            // 但是，如果必须将部分URL附加到基本URL，则应将它们作为字符串连接：URL(string: baseUrl.absoluteString + path)。
            // 或者在URL的absoluteString上使用removingPercentEncoding。
            // 所以如果你的url中含有"?"，需要使用上边处理，或者拆为参数也可以
            // 这个重写就是为了解决这个问题;
            // 但是，请注意：
            // 最好的解决办法是将query部分作为url parameters进行传递；
            // 所以接下来把所有get请求的url中含有?的进行query参数拆分；
            url: URL(target: target).absoluteString.removingPercentEncoding!,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}



