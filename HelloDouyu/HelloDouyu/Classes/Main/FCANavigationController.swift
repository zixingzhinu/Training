//
//  FCANavigationController.swift
//  HelloDouyu
//
//  Created by James on 2018/9/28.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

class FCANavigationController: UINavigationController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor.black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? UIStatusBarStyle.default
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
