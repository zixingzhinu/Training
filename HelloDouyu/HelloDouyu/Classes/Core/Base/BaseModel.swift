//
//  BaseModel.swift
//  HelloDouyu
//
//  Created by James on 2019/1/22.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

@objcMembers
class BaseModel: NSObject {

    override init() {
        
    }
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        print("undefinedKey: \(key) -- value: \(value ?? "")")
    }
}
