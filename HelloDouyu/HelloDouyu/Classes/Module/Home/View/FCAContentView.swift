//
//  FCAContentView.swift
//  HelloDouyu
//
//  Created by James on 2018/9/30.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

protocol FCAContentViewDelegate: class {
    func contentView(_ contentView: FCAContentView, selectedPage:CGFloat, progress: CGFloat)
}

private let kContentCellID = "kContentCellID"

class FCAContentView: UIView {

    private let childVcs: [UIViewController]
    private let parentVc: UIViewController
    private let pageConfig: FCAPageConfig
    weak var delegate: FCAContentViewDelegate?
    
    // MARK:- lazy
    private lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: bounds.width, height: bounds.height)
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
//        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: kContentCellID)
//        collectionView.register(self.classForCoder, forCellWithReuseIdentifier: kContentCellID)
        return collectionView
    }()
    
    
    // MARK:- lifeCycle
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController, pageConfig: FCAPageConfig) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        self.pageConfig = pageConfig
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- private
    private func setupUI() {
        setupCollectionView()
        for childVc in childVcs {
            parentVc.addChild(childVc)
        }
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
    }
}

extension FCAContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        let childView = childVcs[indexPath.row].view
        if !cell.contentView.subviews.isEmpty {
            cell.contentView.subviews.map { (view: UIView) -> UIView in
                view.removeFromSuperview()
                return view
            }
        }
        cell.contentView.addSubview(childView!)
        return cell
    }
    
    
}

extension FCAContentView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let pageF = offsetX / bounds.width
        let progress = (offsetX - pageF.rounded(.down) * bounds.width) / bounds.width
        delegate?.contentView(self, selectedPage: pageF, progress: progress)
//        CGFloat
    }
}

extension FCAContentView: FCATitleViewDelegate {
    
    func titleView(_ titleView: FCATitleView, selectedIndex: Int) {
        let indexPath = IndexPath(item: selectedIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
}
