//
//  HomeMainModel.swift
//  HelloDouyu
//
//  Created by James on 2019/1/17.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

@objcMembers
class HomeMainModel: NSObject {

    var title: String = ""
    var type: Int = 0
    
    override init() {
        
    }
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
}
