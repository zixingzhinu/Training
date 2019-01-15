//
//  WaterFallCollectionViewFlowLayout.swift
//  HelloDouyu
//
//  Created by James on 2019/1/14.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

protocol WaterFallCollectionViewFlowLayoutDataSource:class {
    func numbersOfColumn() -> Int
    func heightForItem(item: Int) -> CGFloat
}

class WaterFallCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate lazy var layoutAttrs = [UICollectionViewLayoutAttributes]()
    weak var dataSource: WaterFallCollectionViewFlowLayoutDataSource?
    fileprivate lazy var colsNum: Int = {
        guard let dataSource = dataSource else {
            fatalError("必须实现数据源代理")
        }
        return dataSource.numbersOfColumn()
    }()
    
    fileprivate lazy var colsHeightArray = Array.init(repeating: sectionInset.top, count: colsNum)
    
    

    override func prepare() {
        let colsNumF = CGFloat(colsNum)
        let itemNums = collectionView!.numberOfItems(inSection: 0)
        let width: CGFloat = (collectionView!.ct_width() - sectionInset.left - sectionInset.right - minimumInteritemSpacing * (colsNumF - 1)) / colsNumF
        for i in 0..<itemNums {
            let minColHeight = colsHeightArray.min() ?? 0
            let currIndex = colsHeightArray.firstIndex(of: minColHeight) ?? 0
            let itemH = dataSource?.heightForItem(item: i) ?? 0
            let indexPath = IndexPath(item: i, section: 0)
            let layoutAttr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let left: CGFloat = sectionInset.left + CGFloat(currIndex) * (minimumInteritemSpacing + width)
            let top: CGFloat = minColHeight
            let height: CGFloat = itemH
            layoutAttr.frame = CGRect(x: left, y: top, width: width, height: height)
            layoutAttrs.append(layoutAttr)
            colsHeightArray[currIndex] += (minimumLineSpacing + height)
        }
    }
}

extension WaterFallCollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttrs
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.ct_width(), height: (colsHeightArray.max() ?? 0) + sectionInset.bottom)
    }
    
    
}
