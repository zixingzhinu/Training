//
//  WATabBarController.swift
//  WanAndroidSwift
//
//  Created by James on 2021/2/25.
//

import UIKit

class WATabBarController: UITabBarController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVc = getChildViewController(vc: HomeViewController(), title: "首页", imageName: "ic_bottom_bar_home", selectedImageName: "ic_bottom_bar_home")
        let treeVc = getChildViewController(vc: TreeViewController(), title: "体系", imageName: "ic_bottom_bar_navi", selectedImageName: "ic_bottom_bar_navi")
        let projectVc = getChildViewController(vc: ProjectViewController(), title: "项目", imageName: "ic_bottom_bar_project", selectedImageName: "ic_bottom_bar_project")
        let mineVc = getChildViewController(vc: MineViewController(), title: "我的", imageName: "ic_bottom_bar_mine", selectedImageName: "ic_bottom_bar_mine")
        setViewControllers([homeVc, treeVc, projectVc, mineVc], animated: false)
    }
    
    
    /// 创建一个TabBarController的ChildViewController
    /// - Parameters:
    ///   - vc: 子控制器
    ///   - title: 显示文本
    ///   - imageName: 正常显示的图片
    ///   - selectedImageName: 选中时显示的图片
    /// - Returns: 封装好的ViewController
    func getChildViewController(vc: UIViewController, title: String, imageName: String, selectedImageName: String) -> UIViewController {
        let image = UIImage(named: imageName)
        let selectedImage = UIImage(named: selectedImageName)
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        vc.tabBarItem = tabBarItem
        let nav = WANavigationController(rootViewController: vc)
        return nav
    }
}
