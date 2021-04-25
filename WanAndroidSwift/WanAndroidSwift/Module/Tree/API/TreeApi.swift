//
//  TreeApi.swift
//  WanAndroidSwift
//
//  Created by James on 2021/4/22.
//

import Foundation

enum TreeApi {
    // 体系数据
    case treeCategory
    // 知识体系下的文章
    case treeCategoryArticle(String, String)
}

extension TreeApi: VLTargetType {
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var path: String {
        return ""
    }
}
