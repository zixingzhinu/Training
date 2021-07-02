//
//  Config+URL.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/3.
//

typealias ConfApi = Config.WanAndroidApi

extension Config {
    
    struct WanAndroidApi {
        static let baseURL = "https://www.wanandroid.com/"
        
        // MARK: - 首页数据
        static let home_banner = "banner/json"
        /// 首页文章列表，序号从0开始拼接
//        static let home_article_list = "article/list/0/json"
        static func homeArticleList(index: String) -> String {
            return "article/list/" + index + "/json"
        }
        /// 置顶文章
        static let home_article_top = "article/top/json"
        
        // MARK: - 体系数据
        static let tree_category = "tree/json"
        static func tree_article_list(pageIndex: String, cid: String) -> String {
            "article/list/\(pageIndex)/json?cid=\(cid)"
        }
    }
}
