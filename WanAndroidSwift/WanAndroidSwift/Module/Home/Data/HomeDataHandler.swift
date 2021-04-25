//
//  HomeDataHandler.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/3.
//  首页数据处理器

import Foundation
import PKHUD

struct HomeDataHandler {
    
    static let sharedHander = HomeDataHandler()
    private init() {}
    
    /// 获取首页Banner数据
    func getHomeBanner(success: @escaping SuccessClosure<[HomeBannerModel]>,
                       failure: @escaping FailureClosure) {
        HUD.show()
        NetworkManager.requestJSON(targetType: HomeApi.homeBanner, [HomeBannerModel].self) { (result) in
            HUD.hide()
            success(result)
        } failure: { (error) in
            HUD.show(.error)
            HUD.hide()
            failure(error)
        };
        
    }
    
    func getHomeTopArticle(success: @escaping SuccessClosure<[HomeTopArticleModel]>, failure: @escaping FailureClosure) {
        HUD.show()
        NetworkManager.requestJSON(targetType: HomeApi.homeTopArticle, [HomeTopArticleModel].self) { (result) in
            HUD.hide()
            printDebug(result)
            success(result)
        } failure: { (error) in
            HUD.hide()
            failure(error)
        };

    }
    
    func getHomeArticleList(index: String, success: @escaping SuccessClosure<HomeArticleListModel>, failure: @escaping FailureClosure) {
        HUD.show()
        NetworkManager.requestJSON(targetType: HomeApi.homeArticleList(index), HomeArticleListModel.self) { (result) in
            HUD.hide()
            success(result)
        } failure: { (error) in
            HUD.hide()
            failure(error)
        }

    }
}
