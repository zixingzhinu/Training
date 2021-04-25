//
//  WebActionHandler.swift
//  WanAndroidSwift
//
//  Created by James on 2021/4/13.
//

import WKWebViewJavascriptBridge

class WebActionHandler {
    
    static let shared: WebActionHandler = WebActionHandler()
    
    private init() {}
    
    func handleData(with data: [String: Any]?, callback: WKWebViewJavascriptBridgeBase.Callback?) {
        
    }
}
