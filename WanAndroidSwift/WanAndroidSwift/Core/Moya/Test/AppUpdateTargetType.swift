//
//  AppUpdateTargetType.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/21.
//  Copyright © 2020 FinupCredit. All rights reserved.
//

import Foundation

enum AppUpdateTargetType {
    case appUpdate
}

extension AppUpdateTargetType: VLTargetType {
    var parameters: [String : Any]? {
        nil
    }
    
    var path: String {
        RMTeamConfig.URL.api_appVersion_getVersion_ + String(AppUpdateInfoModel.SystemType.iOS.rawValue)
    }
}
