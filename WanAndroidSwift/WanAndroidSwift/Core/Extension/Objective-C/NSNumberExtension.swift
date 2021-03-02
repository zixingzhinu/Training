//
//  NSNumberExtension.swift
//  HelloSwiftKits
//
//  Created by James on 2019/7/28.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import Foundation

// MARK: - 数字转换成字符串金额   11121.01   -> "11,121.01"  三位一个逗号
extension NSNumber {
    var dollars: String {
        let formatter: NumberFormatter = NumberFormatter()
        var result: String?
        formatter.numberStyle = NumberFormatter.Style.decimal
        result = formatter.string(from: self)
        if result == nil {
            return "error"
        }
        return result!
    }
}
