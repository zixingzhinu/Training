//
//  HomeApi.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/3.
//


enum HomeApi {
    /// 首页-banner
    case homeBanner
    /// 首页-文章列表
    case homeArticleList(String)
    /// 首页-置顶文章
    case homeTopArticle
}

extension HomeApi: VLTargetType {
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var path: String {
        switch self {
        case .homeBanner:
            return ConfApi.home_banner
        case .homeTopArticle:
            return ConfApi.home_article_top
        case .homeArticleList(let index):
            return ConfApi.homeArticleList(index: index)
        }
    }
    
}
