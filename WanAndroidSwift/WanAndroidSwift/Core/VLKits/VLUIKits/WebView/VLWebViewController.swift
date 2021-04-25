//
//  VLWebViewController.swift
//  WanAndroidSwift
//
//  Created by James on 2021/4/8.
//

import UIKit
import WebKit
import WKWebViewJavascriptBridge

/// 自定义WebViewController
class VLWebViewController: BaseViewController {
    
    // MARK: - LifeCycle
    convenience init(url: String, title: String) {
        self.init()
        self.urlString = url
        self.titleString = title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        progressView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view.safeAreaInsets)
            make.height.equalTo(2)
        }
        webView.snp.makeConstraints { (make) in
            make.left.bottom.right.top.equalTo(view.safeAreaInsets)
//            make.top.equalTo(progressView.snp.bottom)
        }
    }
    
    // MARK: - Public Stored Properties
    var urlString: String = ""
    var titleString: String?
    var timeoutInterval: TimeInterval = 0
    
    // MARK: - Private Stored properties
    private var offsetObservation: NSKeyValueObservation?
    private var titleObservation: NSKeyValueObservation?
    private var progressObservation: NSKeyValueObservation?
    private var webInteraction: WebInteraction?
    // MARK: - Computed properties
    
    // MARK: - lazy UI
    private lazy var webView: WKWebView = {
        let _webView = WKWebView(frame: view.bounds, configuration: webViewConfiguration)
        _webView.uiDelegate = self
        _webView.navigationDelegate = self
        _webView.allowsBackForwardNavigationGestures = true
        _webView.backgroundColor = UIColor.clear
        _webView.isMultipleTouchEnabled = false
        _webView.scrollView.backgroundColor = UIColor.clear
        _webView.scrollView.bounces = false
        if #available(iOS 11.0, *) {
            _webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        if #available(iOS 9.0, *) {
            _webView.customUserAgent = webViewUserAgent
        }
        return _webView
    }()
    
    private lazy var webViewConfiguration: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        let preferences = WKPreferences()
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preferences.minimumFontSize = 9.0;
        //设置是否支持javaScript 默认是支持的
        preferences.javaScriptEnabled = true;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = true;
        config.preferences = preferences;
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = true;
        config.processPool = processPool
        config.userContentController = userContentController
        // 使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        config.allowsInlineMediaPlayback = true
        
        // 设置请求的User-Agent信息中应用程序名称 iOS9后可用
        if #available(iOS 9.0, *) {
            config.applicationNameForUserAgent = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
//            config.applicationNameForUserAgent = @"ChinaDailyForiPad";
        } else {
            // Fallback on earlier versions
        }
        
        // 设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        if #available(iOS 10.0, *) {
            config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypes.all
        } else if #available(iOS 9.0, *) {
            config.requiresUserActionForMediaPlayback = true
        } else {
            config.mediaPlaybackRequiresUserAction = true
        }
        return config
    }()
    
    private lazy var processPool: WKProcessPool = {
        WKProcessPool()
    }()
    
    private lazy var userContentController: WKUserContentController = {
        let controller = WKUserContentController()
        let cookie = "document.cookie = 'fromapp=ios';"
        let cookieScript = WKUserScript(source: cookie, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        controller.addUserScript(cookieScript)
        return controller
    }()
    
    private lazy var webViewUserAgent: String = {
        let oldAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148"
        /*
         在原有UA的基础上拼接h5需要的UA参数,拼接规则如下：
         &{"appName":"BestRiver","type":"IOS"}&
         神策埋点打通App与H5添加/sa-sdk-ios字段
         */
        let newUserAgent = "\(oldAgent)&{\"appName\":\"BestRiver\", \"type\":\"IOS\" \"/sa-sdk-ios\" }&"
        UserDefaults.standard.register(defaults: ["UserAgent": newUserAgent, "User-Agent": newUserAgent])
        UserDefaults.standard.synchronize()
        return newUserAgent
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
//        progressView.progressTintColor = UIColor.green
        progressView.trackTintColor = UIColor.clear
        return progressView
    }()
}

// MARK: - Public Method
extension VLWebViewController {
    func loadRequest(with urlString: String, timeoutInterval: TimeInterval) {
        let tmpUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: tmpUrlString!)
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
        webView.load(request)
    }
    
    func call(data: Any? = nil, callback: WKWebViewJavascriptBridgeBase.Callback? = nil) {
        webInteraction?.call(data: data, callback: callback)
    }
}

// MARK: - Private Method
extension VLWebViewController {
    private func setup() {
        setupUI()
        setupObservers()
        setupWKWebViewJavaScriptBridge()
        loadRequest(with: urlString , timeoutInterval: timeoutInterval)
    }
    
    private func setupUI() {
        view.addSubview(webView)
        view.addSubview(progressView)
    }
    
    private func setupObservers() {
        offsetObservation = webView.observe(\WKWebView.scrollView.contentOffset, options: .new, changeHandler: { (_, change) in
            
        })
        /// 监听title变更
        titleObservation = webView.observe(\WKWebView.title, options: .new, changeHandler: { [weak self] (_, change) in
            guard let strongSelf = self else { return }
            guard let title = change.newValue else { return }
            strongSelf.title = title
        })
        /// 监听进度变更
        progressObservation = webView.observe(\WKWebView.estimatedProgress, options: [.new]) { [weak self] (webView, change) in
            guard let strongSelf = self else { return }
            guard let progress = change.newValue else { return }
            if strongSelf.progressView.isHidden {
                return
            }
            if progress >= strongSelf.progressView.progress.double {
                strongSelf.progressView.setProgress(progress.float, animated: true)
            }
            else {
                strongSelf.progressView.setProgress(progress.float, animated: false)
            }
        }
    }
    
    private func setupWKWebViewJavaScriptBridge() {
        webInteraction = WebInteraction(webView: webView)
        webInteraction?.register()
    }
    /// 不需要了，使用Swift 4 新设计的KVO API
    private func removeObservers() {
        
    }
}

// MARK: - WKNavigationDelegate
extension VLWebViewController: WKNavigationDelegate {
    /// 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    /// 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.progressView.setProgress(0, animated: false)
    }
    
    /// 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    /// 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.progressView.setProgress(0, animated: false)
    }
    
    /// 提交/请求/导航发生错误时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.progressView.setProgress(0, animated: false)
    }
    
    /// 接收到服务器跳转请求即服务重定向时之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    
    /// 进程被终止时调用
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
    
    /// 需要响应身份验证时调用 同样在block中需要传入用户身份凭证
    /// 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
    /// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // 用户身份信息
//        let newCred = URLCredential(user: "user123", password: "user123", persistence: .none)
        // 为 challenge 的发送方提供 credential
//        challenge.sender?.use(newCred, for: challenge)
//        completionHandler(.useCredential, newCred)
        // 加载不受信任的https
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let card = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, card)
        }
    }
    
    /// 在发送请求之前，决定是否跳转
    /// - Parameters:
    ///   - webView: 实现该代理的webview
    ///   - navigationAction: 当前navigation
    ///   - decisionHandler: 是否调转block
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else { return }
        guard let url_scheme = url.scheme else { return }
        printDebug("decidePolicyForNavigationAction 要跳转的url -----> url.absoluteString = \(url.absoluteString)")
        // 打电话
        if url_scheme == "tel" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                // 注意：：：一定要加上这句,否则会打开新页面
                decisionHandler(.cancel)
                return
            }
        }
        // 打开AppStore
        if url.absoluteString.contains("itunes.apple.com") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                // 注意：：：一定要加上这句,否则会打开新页面
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    
    /// 在发送请求之前，决定是否跳转
    /// - Parameters:
    ///   - webView: 实现该代理的webview
    ///   - navigationAction: 当前navigation
    ///   - preferences: 页面处理
    ///   - decisionHandler: 是否调转block
    @available(iOS 13.0, *)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        guard let url = navigationAction.request.url else { return }
        guard let url_scheme = url.scheme else { return }
        printDebug("decidePolicyForNavigationAction 要跳转的url -----> url.absoluteString = \(url.absoluteString)")
        // 打电话
        if url_scheme == "tel" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                // 注意：：：一定要加上这句,否则会打开新页面
                decisionHandler(.cancel, preferences)
                return
            }
        }
        // 打开AppStore
        if url.absoluteString.contains("itunes.apple.com") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                // 注意：：：一定要加上这句,否则会打开新页面
                decisionHandler(.cancel, preferences)
                return
            }
        }
        decisionHandler(.allow, preferences)
    }
    
    /// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        let urlString = navigationResponse.response.url?.absoluteString
//        printDebug(urlString)
        //允许跳转
        decisionHandler(.allow);
        //不允许跳转
//        decisionHandler(.cancel);
    }
}

// MARK: - WKUIDelegate
extension VLWebViewController: WKUIDelegate {
    
    /// 打开新的window时依靠刷新  页面是弹出窗口 _blank 处理
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        let frameInfo = navigationAction.targetFrame;
        if (!(frameInfo?.isMainFrame ?? false)) {
            webView.load(navigationAction.request)
        }
        return nil;
    }
    
    /// 关闭WebView
    func webViewDidClose(_ webView: WKWebView) {
        
    }
    
    /**
     *  web界面中有弹出警告框时调用
     *
     *  @param webView           实现该代理的webview
     *  @param message           警告框中的内容
     *  @param completionHandler 警告框消失调用
     */
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        if webView != self.webView {
            return
        }
        let alertController = UIAlertController(title: "提示", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: { (alertAction) in
            completionHandler()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// 输入框
    /// JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        if webView != self.webView {
            return
        }
        let alertController = UIAlertController(title: prompt, message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: "完成", style: .default, handler: { (alertAction) in
            completionHandler(alertController.textFields?[0].text ?? "")
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// 确认框
    /// JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        if webView != self.webView {
            return
        }
        let alertController = UIAlertController(title: "提示", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (alertAction) in
            completionHandler(false)
        }))
        alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: { (alertAction) in
            completionHandler(true)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
