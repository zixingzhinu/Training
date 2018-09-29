//
//  HomeViewController.swift
//  HelloDouyu
//
//  Created by James on 2018/9/28.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

class HomeViewController: FCABaseViewController {

    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        setupNavigationBarItems()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    /// 设置导航栏
    private func setupNavigationBarItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "home-logo"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_btn_follow"), style: .plain, target: self, action: #selector(followItemDidClick(btn:)))
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 32))
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
        
        let ivars = my_objc_ivars(of: type(of: searchBar))
        for item in ivars {
            print("变量：\(item)")
        }
        
//        var p_count: UInt32 = 0
//        if let ivars = class_copyIvarList(type(of: clazz), &p_count) {
//            for i in 0..<p_count {
//                let p = ivars[Int(i)]
//                let name = String(cString:ivar_getName(p)!)
//
//                print("成员变量:\(name)")
//                arr.append(name)
//            }
//            free(ivars)
//        }
        
//        let ivars = objc_ivars(of: type(of: searchBar))
//        for item in ivars {
//            print("变量：\(item)")
//        }
    }
    
    
    @objc private func followItemDidClick(btn:UIBarButtonItem) {
        print("收藏按钮被点击了, \(btn)")
        view.window?.endEditing(true)
//        for item in navigationItem.titleView!.subviews[0].subviews {
//            print(item)
//        }
        (navigationItem.titleView!.subviews[0].subviews[1] as! UITextField).textColor = UIColor.white
        (navigationItem.titleView!.subviews[0].subviews[1].subviews[2] as! UILabel).textColor = UIColor.white
    }

}

extension HomeViewController {
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
//            free(ivars)
        }
        return arr
    }
    
    public func my_objc_methods(of clazz: AnyClass) -> [String] {
        
        var methodArr = [String]()
        var m_count:UInt32 = 0
        if let methods = class_copyMethodList(clazz, &m_count){
            debugPrint(methods[0]);
            
            for i in 0..<m_count{
                let m = methods[Int(i)];
                let sel = method_getName(m);
                let name = sel_getName(sel);
                let method = NSStringFromSelector(sel)
                debugPrint("方法:\(name): \(method)");
                methodArr.append(method)
            }
            free(methods)
        }
        return methodArr
    }
}

extension HomeViewController {
    public func objc_methods(of clazz: AnyClass) -> [String] {
        var count: UInt32 = 0
        let methodList = class_copyMethodList(clazz, &count)
        
        return (0..<count).compactMap { idx in
            methodList.map { method_getName($0.advanced(by: Int(idx)).pointee).description }
        }
    }
    
    public func objc_properties(of clazz: AnyClass) -> [String] {
        var count: UInt32 = 0
        let propertyList = class_copyPropertyList(clazz, &count)
        
        return (0..<count).compactMap { idx in
            propertyList.map { String(cString: property_getName($0.advanced(by: Int(idx)).pointee)) }
        }
    }
    
    public func objc_ivars(of clazz: AnyClass) -> [String] {
        var count: UInt32 = 0
        let ivarList = class_copyIvarList(clazz, &count)
        
        return (0..<count).compactMap { idx in
            ivarList.flatMap { ivar_getName($0.advanced(by: Int(idx)).pointee).map({ String(cString: $0) }) }
        }
    }
    
    public func objc_protocols(of clazz: AnyClass) -> [String] {
        var count: UInt32 = 0
        let protocolList = class_copyProtocolList(clazz, &count)
        
        return (0..<count).compactMap { idx in
            String(cString: protocol_getName(protocolList![Int(idx)]))
        }
    }
}


