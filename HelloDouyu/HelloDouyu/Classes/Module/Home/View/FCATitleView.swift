//
//  FCATitleView.swift
//  HelloDouyu
//
//  Created by James on 2018/9/30.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

class FCATitleView: UIView {

    let titles: [String]
    let pageConfig: FCAPageConfig
    
    // MARK:- lifeCycle
    init(frame: CGRect, titles: [String], pageConfig: FCAPageConfig) {
        self.titles = titles
        self.pageConfig = pageConfig
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("we have not implements this init function")
    }
    
    // MARK:- private
    private func setupSubviews() {
        for title in titles {
            let btn = UIButton(type: .custom)
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(pageConfig.titleColorNormally, for: .normal)
            btn.setTitleColor(pageConfig.titleColorSelected, for: .selected)
        }
        
    }
}
