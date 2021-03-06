//
//  WaterFallViewController.swift
//  HelloDouyu
//
//  Created by James on 2019/1/13.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

class WaterFallViewController: FCABaseViewController {
    
    var type: HomeMainModel!
    
    fileprivate let cellId: String = "cellId"
    fileprivate lazy var waterFallViewModel = WaterFallViewModel()
//    fileprivate lazy var dataSource: [String] = {
//        var dataSource = [String]()
//        for i in 0..<50 {
//            dataSource.append("\(i)")
//        }
//        return dataSource
//    }()
    
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
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
//        print(WaterFallCollectionViewCell.className)
//        print(collectionView.instanceClassName)
        collectionView.register(UINib(nibName: WaterFallCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: cellId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData(index: 0)
    }
    
    deinit {
        print("\(WaterFallViewController.self) deinit")
    }

}
// MARK:- private method
extension WaterFallViewController {
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(self.view)
        }
    }
    
    func loadData(index: Int) {
        waterFallViewModel.loadWaterFallData(model: type, index: index) {
            self.collectionView.reloadData()
        }
    }
}

// MARK:- <UICollectionViewDataSource, UICollectionViewDelegate>
extension WaterFallViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return waterFallViewModel.waterFallModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WaterFallCollectionViewCell
//        cell.backgroundColor = UIColor.randomColor()
        cell.waterFallModel = waterFallViewModel.waterFallModelArray[indexPath.item]
        if indexPath.item == waterFallViewModel.waterFallModelArray.count - 1 {
            loadData(index: waterFallViewModel.waterFallModelArray.count)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVc = RoomViewController()
        roomVc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(roomVc, animated: true)
    }
    
}

// MARK:- <WaterFallCollectionViewFlowLayoutDataSource>
extension WaterFallViewController: WaterFallCollectionViewFlowLayoutDataSource {
    func numbersOfColumn() -> Int {
        return 2
    }
    
    func heightForItem(item: Int) -> CGFloat {
        return item % 2 == 0 ? screenWidth * 2 / 3 : screenWidth / 2
    }
    
    
}
