//
//  HomeViewController.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/1.
//  首页

import UIKit
import FSPagerView
import MJRefresh

/// 首页控制器
class HomeViewController: BaseViewController {
    
    // MARK: - Const
    let CELL_ID_BANNER = "CELL_ID_BANNER"
    let CELL_TOP_ARTICLE = "CELL_TOP_ARTICLE"
    
    // MARK: - Properties
    private var currentPageIndex: String = "0"
    private var homeBannerModels: [HomeBannerModel]?
    private var homeTopArticleModels: [[HomeTopArticleModel]] = []
//    private var homeArticleModels: [[HomeTopArticleModel]] {
//        homeTopArticleModels
//    }
    
    
    // MARK: - lazy Data
    private lazy var topArticleDataSource = MyDataSource(anItems: &homeTopArticleModels, identifier: CELL_TOP_ARTICLE, clasure: { (cell, item, indexPath) in
        let cell = cell as! HomeTableViewCell
        cell.homeTopArticleModel = item as? HomeTopArticleModel
    })
    
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
//        table.separatorStyle = .none
        table.clearEstimatedHeight()
        table.clearContentInsetAdjustmentBehavior(vc: self)
        table.dataSource = topArticleDataSource
        table.delegate = self
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: CELL_TOP_ARTICLE)
        return table
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        requestData()
//        showMems(val: &homeTopArticleModels)
        setupUI()
    }
    /// 初始化UI
    private func setupUI() {
        view.addSubview(tableView)
        tableView.tableHeaderView = bannerView
//        view.addSubview(bannerView)
        bannerView.addSubview(bannerDotView)
        addRefreshHeader()
    }
    
    private func addRefreshHeader() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.requestData()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        bannerView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.navigationController!.navigationBar.snp.bottom)
//            make.left.right.equalTo(self.view)
//            make.height.equalTo(200)
//        }
        bannerDotView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(bannerView)
            make.height.equalTo(25)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view.safeAreaInsets)
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
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
        requestHomeTopArticle()
        requestHomeArticleList(index: "0")
    }
    
    private func requestHomeTopArticle() {
        HomeDataHandler.sharedHander.getHomeTopArticle { (result) in
            self.homeTopArticleModels.insert(result!, at: 0)
            self.topArticleDataSource.items.insert(result!, at: 0)
            self.tableView.reloadData()
            self.tableView.mj_header?.endRefreshing()
        }
    }
    
    private func requestHomeArticleList(index: String) {
        HomeDataHandler.sharedHander.getHomeArticleList(index: index) { (result) in
            self.topArticleDataSource.addData(mItems: result?.datas ?? [])
            self.tableView.reloadData()
            self.tableView.mj_header?.endRefreshing()
        }
    }
}
