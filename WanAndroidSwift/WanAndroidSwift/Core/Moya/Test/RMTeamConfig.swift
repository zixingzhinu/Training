//
//  RMTeamConfig.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/21.
//  Copyright © 2020 FinupCredit. All rights reserved.
//

import Foundation

struct RMTeamConfig {
    struct URL {
        #if DEBUG
        static let baseUrl =  "http://bestbuy-sale-cloud-server.bestbuy.beta" //  "http://bestbuy-sale-cloud-server.bestbuy.test" //
        #else
        static let baseUrl = "https://sale.anymai.com"
        #endif
    }
    
    struct H5URL {
        #if DEBUG
        static let baseUrl = "http://smart-test.anymai.com"
        #else
        static let baseUrl = "https://sale-h5.anymai.com"
        #endif
    }
}

// MARK: - app版本信息接口
extension RMTeamConfig.URL {
    /// 查询app版本信息
    static let api_appVersion_getVersion_ = "/api/appVersion/getVersion/"
}
