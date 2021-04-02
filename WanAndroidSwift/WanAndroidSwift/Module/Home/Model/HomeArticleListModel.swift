//
//  HomeArticleListModel.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/29.
//

import Foundation


class HomeArticleListModel : NSObject, NSCoding, Decodable {

    var curPage : Int!
    var datas : [HomeTopArticleModel]!
    var offset : Int!
    var over : Bool!
    var pageCount : Int!
    var size : Int!
    var total : Int!


    ///     Instantiate the instance using the passed dictionary values to set the properties values
    init(fromDictionary dictionary: [String:Any]) {
        curPage = dictionary["curPage"] as? Int
        datas = [HomeTopArticleModel]()
        if let datasArray = dictionary["datas"] as? [[String:Any]] {
            for dic in datasArray {
                let value = HomeTopArticleModel(fromDictionary: dic)
                datas.append(value)
            }
        }
        offset = dictionary["offset"] as? Int
        over = dictionary["over"] as? Bool
        pageCount = dictionary["pageCount"] as? Int
        size = dictionary["size"] as? Int
        total = dictionary["total"] as? Int
    }

    ///     Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if curPage != nil {
            dictionary["curPage"] = curPage
        }
        if datas != nil {
            var dictionaryElements = [[String:Any]]()
            for datasElement in datas {
                dictionaryElements.append(datasElement.toDictionary())
            }
            dictionary["datas"] = dictionaryElements
        }
        if offset != nil {
            dictionary["offset"] = offset
        }
        if over != nil {
            dictionary["over"] = over
        }
        if pageCount != nil {
            dictionary["pageCount"] = pageCount
        }
        if size != nil {
            dictionary["size"] = size
        }
        if total != nil {
            dictionary["total"] = total
        }
        return dictionary
    }

    /// NSCoding required initializer.
    /// Fills the data from the passed decoder
    @objc required init(coder aDecoder: NSCoder)
    {
         curPage = aDecoder.decodeObject(forKey: "curPage") as? Int
         datas = aDecoder.decodeObject(forKey :"datas") as? [HomeTopArticleModel]
         offset = aDecoder.decodeObject(forKey: "offset") as? Int
         over = aDecoder.decodeObject(forKey: "over") as? Bool
         pageCount = aDecoder.decodeObject(forKey: "pageCount") as? Int
         size = aDecoder.decodeObject(forKey: "size") as? Int
         total = aDecoder.decodeObject(forKey: "total") as? Int

    }

    /// NSCoding required method.
    /// Encodes mode properties into the decoder
    @objc func encode(with aCoder: NSCoder)
    {
        if curPage != nil {
            aCoder.encode(curPage, forKey: "curPage")
        }
        if datas != nil {
            aCoder.encode(datas, forKey: "datas")
        }
        if offset != nil {
            aCoder.encode(offset, forKey: "offset")
        }
        if over != nil {
            aCoder.encode(over, forKey: "over")
        }
        if pageCount != nil {
            aCoder.encode(pageCount, forKey: "pageCount")
        }
        if size != nil {
            aCoder.encode(size, forKey: "size")
        }
        if total != nil {
            aCoder.encode(total, forKey: "total")
        }

    }

    override var description: String {
        let dic = toDictionary()
        return dic.jsonString(prettify: true)!
    }

    override var debugDescription: String {
        description
    }
}
