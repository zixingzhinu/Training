//
//  HomeViewController.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/1.
//  首页

import UIKit
import FSPagerView

/// 首页控制器
class HomeViewController: BaseViewController {
    
    // MARK: - Const
    let CELL_ID_BANNER = "CELL_ID_BANNER"
    let CELL_TOP_ARTICLE = "CELL_TOP_ARTICLE"
    
    // MARK: - Properties
    private var homeBannerModels: [HomeBannerModel]?
    private var homeTopArticleModels: [[HomeTopArticleModel]] = []
    
    // MARK: - UIView
    private lazy var bannerView: FSPagerView = {
        let banner = FSPagerView(frame: CGRect(x: 0, y: navigationController!.navigationBarHeight, width: screenWidth, height: 200))
        banner.automaticSlidingInterval = 5.0
        banner.isInfinite = true
        banner.interitemSpacing = 0
        banner.dataSource = self
        banner.delegate = self
        banner.register(FSPagerViewCell.self, forCellWithReuseIdentifier: CELL_ID_BANNER)
        return banner
    }()
    
    private lazy var bannerDotView: FSPageControl = {
        let pageControl = FSPageControl()
        pageControl.contentHorizontalAlignment = .right
        pageControl.contentInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        return pageControl
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.separatorStyle = .none
        table.clearEstimatedHeight()
        table.clearContentInsetAdjustmentBehavior(vc: self)
        table.dataSource = MyDataSource(anItems: homeTopArticleModels, identifier: CELL_TOP_ARTICLE, clasure: { (cell, item, indexPath) in
            
        })
        table.delegate = self
        table.register(cellWithClass: UITableViewCell.self)
        return table
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
        
        setupUI()
    }
    /// 初始化UI
    private func setupUI() {
        view.addSubview(bannerView)
        view.addSubview(bannerDotView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bannerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.navigationController!.navigationBar.snp.bottom)
            make.left.right.equalTo(self.view)
            make.height.equalTo(200)
        }
        bannerDotView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(bannerView)
            make.height.equalTo(25)
        }
    }
    
}

// MARK: -
extension HomeViewController: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return homeBannerModels?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CELL_ID_BANNER, at: index)
        cell.imageView?.vSetImage(homeBannerModels?[index].imagePath ?? "")
        return cell
    }
    
}

// MARK: - FSPagerViewDelegate
extension HomeViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: false)
        
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        bannerDotView.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        bannerDotView.currentPage = pagerView.currentIndex
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
}

// MARK: - Data Handler
extension HomeViewController {
    
    /// 请求数据
    private func requestData() {
        HomeDataHandler.sharedHander.getHomeBanner { (result) in
            self.homeBannerModels = result
            self.bannerView.reloadData()
            self.bannerDotView.numberOfPages = result?.count ?? 0
        }
        HomeDataHandler.sharedHander.getHomeTopArticle { (result) in
            
        }
    }
}
