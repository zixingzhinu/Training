//
//  AppUpdateModel.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/21.
//  Copyright © 2020 FinupCredit. All rights reserved.
//

import Foundation

struct AppUpdateInfoModel: Decodable {
    /// 更新标题
    var title: String
    
    /// 更新内容
    var description: String?
    
    /// 是否强更：0、否，1、是
    var forceUpdate: Int
    
    /// 更新链接URL
    var linkUrl: String
    
    /// 系统类型: 1、IOS, 2、Android
    var systemType: SystemType
    
    /// 版本号：例如 2.1.0
    var version: String
}

extension AppUpdateInfoModel {
    
    /// SystemType
    enum SystemType: Int, Decodable {
        case iOS = 1
        case Android = 2
    }
}
