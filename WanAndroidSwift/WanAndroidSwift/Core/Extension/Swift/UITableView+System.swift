//
//  UITableView+System.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/19.
//

import UIKit

extension UITableView {
    
    @available(iOS 11.0, *)
    func clearEstimatedHeight() {
        estimatedRowHeight = 0
        estimatedSectionHeaderHeight = 0
        estimatedSectionFooterHeight = 0
    }
    
    func clearContentInsetAdjustmentBehavior(vc: UIViewController) {
        if #available(iOS 11.0, *) {
            if self.responds(to: #selector(setter: contentInsetAdjustmentBehavior)) {
                contentInsetAdjustmentBehavior = .never
            }
        } else {
            vc.automaticallyAdjustsScrollViewInsets = false;
        }
    }
}
