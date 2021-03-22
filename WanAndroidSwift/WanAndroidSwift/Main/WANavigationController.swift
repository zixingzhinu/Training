//
//  WANavigationController.swift
//  WanAndroidSwift
//
//  Created by James on 2021/2/23.
//

import UIKit

class WANavigationController: UINavigationController {
    // MARK:- Override
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? UIStatusBarStyle.default
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}


extension UINavigationController {
    var navigationBarHeight: CGFloat {
        return navigationBar.frame.height
    }
    var navigationBarBottom: CGFloat {
        return statusBarHeight + navigationBarHeight
    }
}
