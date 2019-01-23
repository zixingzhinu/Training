//
//  NSMutableArray-Extension.swift
//  HelloDouyu
//
//  Created by James on 2019/1/21.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import Foundation

extension NSMutableArray {
    open override func description(withLocale locale: Any?) -> String {
        var str = "[\n"
        self.enumerateObjects ({ (obj, index, stop) in
            str += "\t\(obj), \n"
        })
        str += "]"
        return str
    }
}
