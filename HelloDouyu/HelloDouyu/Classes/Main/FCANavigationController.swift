//
//  FCANavigationController.swift
//  HelloDouyu
//
//  Created by James on 2018/9/28.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

class FCANavigationController: UINavigationController {
    
    var assignScreenTransition: Bool = true
    
    
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        assignViewTransition()
    }
    
    // MARK:- Override
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? UIStatusBarStyle.default
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
    
    

}

extension FCANavigationController {
    // MARK:- private method
    fileprivate func initNavigationBar() {
        navigationBar.barTintColor = UIColor.black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    /// 给整个View赋值系统的push转场退出效果
    fileprivate func assignViewTransition() {
        if !assignScreenTransition {
            return
        }
        self.interactivePopGestureRecognizer?.isEnabled = false
//        interactivePopGestureRecognizer   系统的侧滑POP手势
        /*  找到侧滑手势相关的属性
        var outCount: UInt32 = 0
        guard let ivars = class_copyIvarList(UIGestureRecognizer.self, &outCount) else { return }
        for i in 0..<Int(outCount) {
            let nameP = ivar_getName(ivars[i])
            let name = String(cString: nameP!)
            print("********" + name)
        }
 */
//  [(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x10150c7a0>)]
        guard let targets = interactivePopGestureRecognizer?.value(forKeyPath: "_targets") as? [NSObject] else { return }
//        print(targets.first)
        let targetObj = targets.first!
        let target = targetObj.value(forKeyPath: "target")
        let action = Selector(("handleNavigationTransition:"))
        let pan = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(pan)
        pan.delegate = self
    }
}

extension FCANavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count == 1 {
            return false
        }
        return true
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
