//
//  WATabBarController.swift
//  WanAndroidSwift
//
//  Created by James on 2021/2/25.
//

import UIKit

class WATabBarController: UITabBarController {
    
    func getChildViewController(vc: UIViewController, title: String, imageName: String, selectedImageName: String) -> UIViewController {
        let nav = WANavigationController(rootViewController: vc)
        return nav
    }
}
