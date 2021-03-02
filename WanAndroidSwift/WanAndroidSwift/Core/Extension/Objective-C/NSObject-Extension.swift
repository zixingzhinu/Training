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
    
    func LogIvarList(classString:String){
        
        print("\n\n ********** \(classString)  IvarList ****************\n")
        
        var count:UInt32 = 0
        let list = class_copyIvarList(NSClassFromString(classString), &count)
        for i in 0 ..< Int(count) {
            let ivar = list![i]
            let name = ivar_getName(ivar)
            let type = ivar_getTypeEncoding(ivar)
            print( String(cString: name!),"-----",String(cString: type!),"\n")
        }
    }


    func LogPropertyList(classString:String){
        
        print("\n\n ********** \(classString)  PropertyList ****************\n")
        var count:UInt32 = 0
        let list = class_copyPropertyList(NSClassFromString(classString), &count)
        for i in 0 ..< Int(count) {
            let property = list![i]
            let name = property_getName(property)
            let type = property_getAttributes(property)
            print( String(cString: name),"------",String(cString: type!),"\n")
        }
    }

}
