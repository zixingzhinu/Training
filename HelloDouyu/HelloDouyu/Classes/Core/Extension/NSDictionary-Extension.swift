//
//  NSDictionary-Extension.swift
//  HelloDouyu
//
//  Created by James on 2019/1/21.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import Foundation

extension NSMutableDictionary {
    open override func description(withLocale locale: Any?) -> String {
        var str = "{\n"
        self.enumerateKeysAndObjects { (key, obj, stop) in
            str += "\t\(key)"
            str += ":"
            str += "\(obj)\n"
        }
        str += "}"
        return str
    }
}
