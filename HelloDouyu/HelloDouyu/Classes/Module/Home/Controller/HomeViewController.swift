//
//  HomeViewController.swift
//  HelloDouyu
//
//  Created by James on 2018/9/28.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

class HomeViewController: FCABaseViewController {
    
    private var pageView: FCAPageView!

    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        setupNavigationBarItems()
        setupPageView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        setupPageView()
    }
    
    // MARK:- Action
    @objc private func followItemDidClick(btn:UIBarButtonItem) {
        print("收藏按钮被点击了, \(btn)")
        view.window?.endEditing(true)
//        for item in navigationItem.titleView!.subviews[0].subviews {
//            print(item)
//        }
//        (navigationItem.titleView!.subviews[0].subviews[1] as! UITextField).textColor = UIColor.white
//        (navigationItem.titleView!.subviews[0].subviews[1].subviews[2] as! UILabel).textColor = UIColor.white
    }
    
    // MARK:- private
    /// 设置导航栏
    private func setupNavigationBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "home-logo"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_btn_follow"), style: .plain, target: self, action: #selector(followItemDidClick(btn:)))
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 22))
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
        let searchBarTextField = searchBar.value(forKeyPath: "_searchField") as! UITextField
        searchBarTextField.tintColor = UIColor.red
        searchBarTextField.textColor = UIColor.red
        let searchBarPlaceHolderLabel = searchBarTextField.value(forKey:"placeholderLabel") as? UILabel
        searchBarPlaceHolderLabel?.textColor = UIColor.red
        
        // iOS11开始，如果NavigationBar中titleView为UISearchBar的话，UISearchBar的height会变为56，导致navigationBar的height也会变为56，可以通过强行设置searchBar的高度约束为44来解决，或者在viewDidAppear中才能获取到UISearchBar真正的高度，注意：这里的isActive要设置成true，否则只会生效一次。
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        }
    }
    
    private func setupPageView() {
        let titles = ["搞笑", "视频", "社会", "北京", "中国", "本地化", "图片", "新时代", "轻松一刻", "公开课", "要闻", "科技", "技术开发"]
        var childVcs = [UIViewController]()
        var pageConfig = FCAPageConfig()
//        pageConfig.isHorizontalScrollEnabled = false
        let top = self.navigationController!.navigationBarBottom
        let height = screenheight - self.navigationController!.navigationBarBottom - self.tabBarController!.tabBarHeight
        let pageViewFrame = CGRect(x: 0, y: top, width: screenWidth, height: height)
        for _ in titles {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
        }
        pageView = FCAPageView(frame: pageViewFrame, titles: titles, childVcs: childVcs, parentVc: self, pageConfig: pageConfig)
        view.addSubview(pageView)
    }

}

extension HomeViewController {
    
    /// 调用指定方法动态获取指定类(self)所有成员变量
    fileprivate func my_get_ivars() {
        //        let searchBarTextField = navigationItem.titleView!.value(forKeyPath: "_searchField") as! UITextField
        let ivars = my_objc_ivars(of: type(of: self))
        for item in ivars {
            print("变量：\(item)")
        }
        
        //        获取searchBar对象所有成员变量名
        //        let ivars = objc_ivars(of: type(of: searchBar))
        //        for item in ivars {
        //            print("变量：\(item)")
        //        }
    }
}

extension HomeViewController {
    
    /// 自定义获取指定类的所有成员变量
    ///
    /// - Parameter clazz: 指定类
    /// - Returns: 成员变量名数组
    public func my_objc_ivars(of clazz: AnyClass) -> [String] {
        var arr = [String]()
        var p_count: UInt32 = 0
        if let ivars = class_copyIvarList(clazz, &p_count) {
            for i in 0..<p_count {
                let p = ivars[Int(i)]
                let name = String(cString:ivar_getName(p)!)
                
//                print("成员变量:\(name)")
                arr.append(name)
            }
            free(ivars)
        }
        return arr
    }
    
    /// 获取指定类所有方法
    ///
    /// - Parameter clazz: 指定类
    /// - Returns: 所有方法名数组
    public func my_objc_methods(of clazz: AnyClass) -> [String] {
        
        var methodArr = [String]()
        var m_count:UInt32 = 0
        if let methods = class_copyMethodList(clazz, &m_count){
//            debugPrint(methods[0]);
            
            for i in 0..<m_count{
                let m = methods[Int(i)];
                let sel = method_getName(m);
                let name = sel_getName(sel);
                let method = NSStringFromSelector(sel)
//                debugPrint("方法:\(name): \(method)");
                methodArr.append(method)
            }
            free(methods)
        }
        return methodArr
    }
}

extension HomeViewController {
    
    /// 获取指定类所有方法
    ///
    /// - Parameter clazz: 指定类
    /// - Returns: 所有方法名数组
    public func objc_methods(of clazz: AnyClass) -> [String] {
        var count: UInt32 = 0
        let methodList = class_copyMethodList(clazz, &count)
        
        return (0..<count).compactMap { idx in
            methodList.map { method_getName($0.advanced(by: Int(idx)).pointee).description }
        }
    }
    
    /// 动态获取指定类所有属性
    ///
    /// - Parameter clazz: 指定类
    /// - Returns: 所有属性名数组
    public func objc_properties(of clazz: AnyClass) -> [String] {
        var count: UInt32 = 0
        let propertyList = class_copyPropertyList(clazz, &count)
        
        return (0..<count).compactMap { idx in
            propertyList.map { String(cString: property_getName($0.advanced(by: Int(idx)).pointee)) }
        }
    }
    
    /// 动态获取指定类所有成员变量名
    ///
    /// - Parameter clazz: 指定类
    /// - Returns: 所有成员变量名数组
    public func objc_ivars(of clazz: AnyClass) -> [String] {
        var count: UInt32 = 0
        let ivarList = class_copyIvarList(clazz, &count)
        
        return (0..<count).compactMap { idx in
            ivarList.flatMap { ivar_getName($0.advanced(by: Int(idx)).pointee).map({ String(cString: $0) }) }
        }
    }
    
    /// 动态获取指定类所有协议
    ///
    /// - Parameter clazz: 指定类
    /// - Returns: 所有协议名数组
    public func objc_protocols(of clazz: AnyClass) -> [String] {
        var count: UInt32 = 0
        let protocolList = class_copyProtocolList(clazz, &count)
        
        return (0..<count).compactMap { idx in
            String(cString: protocol_getName(protocolList![Int(idx)]))
        }
    }
}


