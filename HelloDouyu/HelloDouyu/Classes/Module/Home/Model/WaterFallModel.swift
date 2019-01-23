//
//  WaterFallModel.swift
//  HelloDouyu
//
//  Created by James on 2019/1/22.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

class WaterFallModel: BaseModel {
    var avatar: String = ""
    /// 关注数
    var focus: Int = 0
    /// 是否在直播
    var live: Int = 0
    var name: String = ""
    var pic51: String = ""
    var pic74: String = ""
    /// 直播显示方式
    var push: Int = 0
    var roomid: Int = 0
    var isEvenIndex: Bool = false
}
