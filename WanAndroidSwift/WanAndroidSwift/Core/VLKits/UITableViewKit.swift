//
//  UITableViewKit.swift
//  HelloSwiftKits
//
//  Created by James on 2021/3/1.
//

import UIKit

typealias cellConfigureClasure = (_ cell: Any,_ item: Any,_ indexPath: IndexPath)->Void

open class MyDataSource: NSObject, UITableViewDataSource {
    
    var items: [[Any]] = []
    var cellIdentifier: String?
    var configureCellClasure: cellConfigureClasure?
    
    init(anItems: [[Any]],identifier: String,clasure: cellConfigureClasure?) {
        items = anItems
        cellIdentifier = identifier
        if let clasure = clasure {
            configureCellClasure = clasure
        }
    }
    
    func itemAtIndexPath(indexpath: Int) -> [Any] {
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
            configureCellClasure(cell,item,indexPath)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
