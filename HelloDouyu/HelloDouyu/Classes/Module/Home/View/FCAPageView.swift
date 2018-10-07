//
//  FCAPageView.swift
//  HelloDouyu
//
//  Created by James on 2018/9/30.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

class FCAPageView: UIView {
    
    let titles: [String]
    let childVcs: [UIViewController]
    let parentVc: UIViewController
    let pageConfig: FCAPageConfig
    var titleView: FCATitleView!
    var contentView: FCAContentView!
    
    init(frame: CGRect, titles: [String], childVcs: [UIViewController], parentVc: UIViewController, pageConfig: FCAPageConfig) {
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        self.pageConfig = pageConfig
        super.init(frame: frame)
        // 加载UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化UI
    private func setupUI() {
        self.backgroundColor = .white
        setupTitleView()
        setupContentView()
    }
    
    /// 初始化TitleView
    private func setupTitleView() {
        let titleViewFrame = CGRect(x: 0, y: 0, width: screenWidth, height: pageConfig.titleViewH)
        titleView = FCATitleView(frame: titleViewFrame, titles: titles, pageConfig: pageConfig)
        addSubview(titleView)
    }
    
    /// 初始化ContentView
    private func setupContentView() {
        let contentViewFrame = CGRect(x: 0, y: titleView.frame.maxY, width: screenWidth, height: bounds.height - titleView.frame.maxY)
        contentView = FCAContentView(frame: contentViewFrame, childVcs: childVcs, parentVc: parentVc, pageConfig: pageConfig)
        addSubview(contentView)
        // 为titleView设置代理
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}


