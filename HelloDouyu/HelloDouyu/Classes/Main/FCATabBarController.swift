//
//  FCATabBarController.swift
//  HelloDouyu
//
//  Created by James on 2018/9/28.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

class FCATabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVc = getChildViewController(targetVcName:"HomeViewController")
        let rankVc = getChildViewController(targetVcName: "RankViewController")
        let discoverVc = getChildViewController(targetVcName: "DiscoverViewController")
        let mineVc = getChildViewController(targetVcName: "MineViewController")
        setViewControllers([homeVc!, rankVc!, discoverVc!, mineVc!], animated: true)
    }
    
    func getChildViewController(targetVcName: String) -> UINavigationController? {
        guard let clazz = NSClassFromString(getClassName(targetClassName: targetVcName)) as? UIViewController.Type else {
            return nil
        }
        let vc = clazz.init()
        let nav = FCANavigationController(rootViewController:vc)
        print(nav)
        return nav
    }
    
    func getProjectName() -> String {
//        let nameKey = "CFBundleName"
//        let projectName = Bundle.main.object(forInfoDictionaryKey: nameKey) as! String
        // 上下两种方式都可以，目的是获取项目名
        let nameKey = "CFBundleExecutable"
        let projectName = Bundle.main.infoDictionary![nameKey] as! String
        return projectName
    }
    
    /// 获取完整类名
    ///
    /// - Parameter targetClassName: 目标类名
    /// - Returns: 完整类名
    func getClassName(targetClassName: String) -> String {
        // 如果你的工程名字中带有“-” 符号  需要加上 replacingOccurrences(of: "-", with: "_") 这句代码把“-” 替换掉  不然还会报错 要不然系统会自动替换掉 这样就不是你原来的包名了 如果不包含“-”  这句代码 可以不加
        let projectName = getProjectName().replacingOccurrences(of: "-", with: "_")
        let newClassName = projectName + "." + targetClassName
        return newClassName
    }

}
