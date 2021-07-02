//
//  TreeDataHandler.swift
//  WanAndroidSwift
//
//  Created by James on 2021/4/26.
//

import PKHUD

class TreeDataHandler {
    
    
    /// 获取体系分类数据
    /// - Parameters:
    ///   - success: 成功回调
    ///   - failure: 失败回调
    func getTreeCategory(success: @escaping SuccessClosure<[TreeCategoryModel]>, failure: @escaping FailureClosure) {
        HUD.show()
        NetworkManager.requestJSON(targetType: TreeApi.treeCategory, [TreeCategoryModel].self) { (result) in
            HUD.hide()
            success(result)
        } failure: { (error) in
            HUD.hide()
            failure(error)
        }
    }
}
