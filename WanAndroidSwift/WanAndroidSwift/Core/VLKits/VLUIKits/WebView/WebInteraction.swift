//
//  WebInteraction.swift
//  WanAndroidSwift
//
//  Created by James on 2021/4/13.
//

import WKWebViewJavascriptBridge
import WebKit

/// Web交互
class WebInteraction: NSObject {
    
    private var bridge: WKWebViewJavascriptBridge!
    
    init(webView: WKWebView) {
        bridge = WKWebViewJavascriptBridge(webView: webView)
    }
    
    func register() {
        bridge.register(handlerName: "handlerName") { (parameters: [String: Any]?, callback: WKWebViewJavascriptBridgeBase.Callback?) in
            WebActionHandler.shared.handleData(with: parameters, callback: callback)
        }
    }
    
    func register(handlerName: String) {
        bridge.register(handlerName: handlerName) { (parameters: [String: Any]?, callback: WKWebViewJavascriptBridgeBase.Callback?) in
            WebActionHandler.shared.handleData(with: parameters, callback: callback)
        }
    }
    
    func call(data: Any? = nil, callback: WKWebViewJavascriptBridgeBase.Callback? = nil) {
        bridge.call(handlerName: "handlerName", data: data, callback: callback)
    }
    
    func call(handlerName: String, data: Any? = nil, callback: WKWebViewJavascriptBridgeBase.Callback? = nil) {
        bridge.call(handlerName: handlerName, data: data, callback: callback)
    }
}
