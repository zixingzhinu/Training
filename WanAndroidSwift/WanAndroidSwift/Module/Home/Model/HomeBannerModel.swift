//
//  HomeBannerModel.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/5.
//

import Foundation

/// 首页Banner数据模型
class HomeBannerModel : NSObject, NSCoding, Decodable {

    var desc : String!
    var bannerId : Int!
    var imagePath : String!
    var isVisible : Int!
    var order : Int!
    var title : String!
    var type : Int!
    var url : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        desc = dictionary["desc"] as? String
        bannerId = dictionary["id"] as? Int
        imagePath = dictionary["imagePath"] as? String
        isVisible = dictionary["isVisible"] as? Int
        order = dictionary["order"] as? Int
        title = dictionary["title"] as? String
        type = dictionary["type"] as? Int
        url = dictionary["url"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if desc != nil{
            dictionary["desc"] = desc
        }
        if bannerId != nil{
            dictionary["id"] = bannerId
        }
        if imagePath != nil{
            dictionary["imagePath"] = imagePath
        }
        if isVisible != nil{
            dictionary["isVisible"] = isVisible
        }
        if order != nil{
            dictionary["order"] = order
        }
        if title != nil{
            dictionary["title"] = title
        }
        if type != nil{
            dictionary["type"] = type
        }
        if url != nil{
            dictionary["url"] = url
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         desc = aDecoder.decodeObject(forKey: "desc") as? String
         bannerId = aDecoder.decodeObject(forKey: "id") as? Int
         imagePath = aDecoder.decodeObject(forKey: "imagePath") as? String
         isVisible = aDecoder.decodeObject(forKey: "isVisible") as? Int
         order = aDecoder.decodeObject(forKey: "order") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         type = aDecoder.decodeObject(forKey: "type") as? Int
         url = aDecoder.decodeObject(forKey: "url") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if desc != nil{
            aCoder.encode(desc, forKey: "desc")
        }
        if bannerId != nil{
            aCoder.encode(bannerId, forKey: "id")
        }
        if imagePath != nil{
            aCoder.encode(imagePath, forKey: "imagePath")
        }
        if isVisible != nil{
            aCoder.encode(isVisible, forKey: "isVisible")
        }
        if order != nil{
            aCoder.encode(order, forKey: "order")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
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
