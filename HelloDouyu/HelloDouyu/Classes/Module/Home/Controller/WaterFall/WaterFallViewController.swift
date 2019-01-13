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
        var collectionViewLayout = UICollectionViewFlowLayout()
        var collectionView: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
