//
//  NSObject-Extension.swift
//  HelloDouyu
//
//  Created by James on 2019/1/22.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import Foundation

extension NSObject {
    var instanceClassName: String {
        let clazzName = type(of: self).description()
        if clazzName.contains(".") {
            return clazzName.components(separatedBy: ".")[1]
        }
        else {
            return clazzName
        }
    }
    
    class var className: String {
        // 这两种都可以
//        let clazzName = self.description()
        let clazzName = "\(self)"
        if clazzName.contains(".") {
            return clazzName.components(separatedBy: ".")[1]
        }
        else {
            return clazzName
        }
    }
}
