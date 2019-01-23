//
//  WaterFallViewModel.swift
//  HelloDouyu
//
//  Created by James on 2019/1/21.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

class WaterFallViewModel: NSObject {
    
    lazy var waterFallModelArray = [WaterFallModel]()
    
    func loadWaterFallData(model: HomeMainModel, index: Int, completion: @escaping() -> ()) {
        NetworkKit.requestData(url: URL_Home_WaterFall, method: .get, params: ["type": model.type, "index": index, "size": 48]) { (result) in
            guard let resultDict = result as? [String: Any] else {
                return
            }
            guard let messageDict = resultDict["message"] as? [String: Any] else {
                return
            }
            guard let dataArray = messageDict["anchors"] as? [[String: Any]] else {
                return
            }
            for (index, dict) in dataArray.enumerated() {
                let model = WaterFallModel(dict: dict)
                model.isEvenIndex = index % 2 == 0
                self.waterFallModelArray.append(model)
            }
            completion()
        }
    }
}
