//
//  FCATabBarController.swift
//  HelloDouyu
//
//  Created by James on 2018/9/28.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class FCATabBarController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVc = getChildViewController(targetVcName:"HomeViewController", title: "首页", imageName: "live-n", selectedImageName: "live-p")
        let rankVc = getChildViewController(targetVcName: "RankViewController", title: "排行", imageName: "ranking-n", selectedImageName: "ranking-p")
        let discoverVc = getChildViewController(targetVcName: "DiscoverViewController", title: "发现", imageName: "found-n", selectedImageName: "found-p")
        let mineVc = getChildViewController(targetVcName: "MineViewController", title: "我的", imageName: "mine-n", selectedImageName: "mine-p")
        setViewControllers([homeVc!, rankVc!, discoverVc!, mineVc!], animated: true)
        
    }
    
    func getChildViewController(targetVcName: String, title: String, imageName: String, selectedImageName: String) -> UINavigationController? {
        guard let clazz = NSClassFromString(getClassName(targetClassName: targetVcName)) as? UIViewController.Type else {
            return nil
        }
        let vc = clazz.init()
        let selectedImage = UIImage(named: selectedImageName)
//        if let selectedImage = selectedImage {
//            vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
//        }
        // UIColor(red: 207, green: 149, blue: 55, alpha: 1.0)   UIColor("#CF9537")
        let myTabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: selectedImage)
        myTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(r: 207, g: 149, b: 55, a: 1.0)], for: UIControl.State.selected)
        vc.tabBarItem = myTabBarItem
        let nav = FCANavigationController(rootViewController:vc)
//        print(nav)
        return nav
    }
    
    

}

extension FCATabBarController {
    
    /// 获取项目名称
    ///
    /// - Returns: 项目名称
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

extension UITabBarController {
    var tabBarHeight: CGFloat {
        return tabBar.frame.height
    }
}
