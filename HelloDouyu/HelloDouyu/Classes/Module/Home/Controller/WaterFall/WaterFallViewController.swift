//
//  WaterFallViewController.swift
//  HelloDouyu
//
//  Created by James on 2019/1/13.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

class WaterFallViewController: UIViewController {
    
    fileprivate let cellId: String = "cellId"
    
    fileprivate lazy var dataSource: [String] = {
        var dataSource = [String]()
        for i in 0..<50 {
            dataSource.append("\(i)")
        }
        return dataSource
    }()
    
    lazy var collectionView: UICollectionView = {
        var collectionViewLayout = WaterFallCollectionViewFlowLayout()
        collectionViewLayout.dataSource = self
//        let colsNum:CGFloat = 3
        let margin:CGFloat = 10
        let marginSpace:CGFloat = 10
//        let itemW: CGFloat = (self.view.bounds.width - marginLR * 2 - marginSpace * (colsNum - 1)) / colsNum
//        let itemH: CGFloat = itemW
//        collectionViewLayout.itemSize = CGSize(width: itemW, height: itemH)
        collectionViewLayout.minimumLineSpacing = marginSpace
        collectionViewLayout.minimumInteritemSpacing = marginSpace
        collectionViewLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
//        collectionViewLayout.collectionViewContentSize = CGSize(width: view.bounds.width, height: itemH * ())
        var collectionView: UICollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self.view)
        }
    }
    
    deinit {
        print("\(WaterFallViewController.self) deinit")
    }

}

extension WaterFallViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    
}

extension WaterFallViewController: WaterFallCollectionViewFlowLayoutDataSource {
    func numbersOfColumn() -> Int {
        return 3
    }
    
    func heightForItem(item: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(50) + 100)
    }
    
    
}
