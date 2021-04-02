//
//  UITableViewKit.swift
//  HelloSwiftKits
//
//  Created by James on 2021/3/1.
//

import UIKit

typealias CellConfigureClasure<M> = (_ cell: UITableViewCell, _ item: M, _ indexPath: IndexPath)->Void

open class MyDataSource<T>: NSObject, UITableViewDataSource {
    
    var items: [[T]] = []
    var cellIdentifier: String?
    var configureCellClasure: CellConfigureClasure<T>?
    
    init(anItems: inout [[T]],identifier: String,clasure: CellConfigureClasure<T>?) {
        items = anItems
//        showMems(val: &anItems)
//        showMems(val: &items)
        cellIdentifier = identifier
        if let clasure = clasure {
            configureCellClasure = clasure
        }
    }
    
    func addData(mItems: [T]) {
        items.append(mItems)
    }
    
    func itemAtIndexPath(indexpath: Int) -> [T] {
        return items[indexpath]
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (itemAtIndexPath(indexpath: section) as AnyObject).count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
        let item = itemAtIndexPath(indexpath: indexPath.section)[indexPath.row]
        if let configureCellClasure = configureCellClasure {
            configureCellClasure(cell, item, indexPath)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
