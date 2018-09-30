//
//  FCAContentView.swift
//  HelloDouyu
//
//  Created by James on 2018/9/30.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

class FCAContentView: UIView {

    let childVcs: [UIViewController]
    let parentVc: UIViewController
    let pageConfig: FCAPageConfig
    
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController, pageConfig: FCAPageConfig) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        self.pageConfig = pageConfig
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
