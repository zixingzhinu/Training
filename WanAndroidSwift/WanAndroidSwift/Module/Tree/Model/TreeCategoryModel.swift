//
//  TreeCategoryModel.swift
//  WanAndroidSwift
//
//  Created by James on 2021/4/21.
//

import Foundation

class TreeCategoryModel : NSObject, NSCoding, Decodable {

    var children : [TreeCategoryModel]!
    var courseId : Int!
    var id : Int!
    var name : String!
    var order : Int!
    var parentChapterId : Int!
    var userControlSetTop : Bool!
    var visible : Int!


    ///   Instantiate the instance using the passed dictionary values to set the properties values
    init(fromDictionary dictionary: [String:Any]) {
        children = [TreeCategoryModel]()
        if let childrenArray = dictionary["children"] as? [[String:Any]] {
            for dic in childrenArray {
                let value = TreeCategoryModel(fromDictionary: dic)
                children.append(value)
            }
        }
        courseId = dictionary["courseId"] as? Int
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        order = dictionary["order"] as? Int
        parentChapterId = dictionary["parentChapterId"] as? Int
        userControlSetTop = dictionary["userControlSetTop"] as? Bool
        visible = dictionary["visible"] as? Int
    }

    ///   Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if children != nil {
            var dictionaryElements = [[String:Any]]()
            for childrenElement in children {
                dictionaryElements.append(childrenElement.toDictionary())
            }
            dictionary["children"] = dictionaryElements
        }
        if courseId != nil {
            dictionary["courseId"] = courseId
        }
        if id != nil {
            dictionary["id"] = id
        }
        if name != nil {
            dictionary["name"] = name
        }
        if order != nil {
            dictionary["order"] = order
        }
        if parentChapterId != nil {
            dictionary["parentChapterId"] = parentChapterId
        }
        if userControlSetTop != nil {
            dictionary["userControlSetTop"] = userControlSetTop
        }
        if visible != nil {
            dictionary["visible"] = visible
        }
        return dictionary
    }

    /// NSCoding required initializer.
    /// Fills the data from the passed decoder
    @objc required init(coder aDecoder: NSCoder)
    {
         children = aDecoder.decodeObject(forKey :"children") as? [TreeCategoryModel]
         courseId = aDecoder.decodeObject(forKey: "courseId") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         order = aDecoder.decodeObject(forKey: "order") as? Int
         parentChapterId = aDecoder.decodeObject(forKey: "parentChapterId") as? Int
         userControlSetTop = aDecoder.decodeObject(forKey: "userControlSetTop") as? Bool
         visible = aDecoder.decodeObject(forKey: "visible") as? Int

    }

    /// NSCoding required method.
    /// Encodes mode properties into the decoder
    @objc func encode(with aCoder: NSCoder)
    {
        if children != nil {
            aCoder.encode(children, forKey: "children")
        }
        if courseId != nil {
            aCoder.encode(courseId, forKey: "courseId")
        }
        if id != nil {
            aCoder.encode(id, forKey: "id")
        }
        if name != nil {
            aCoder.encode(name, forKey: "name")
        }
        if order != nil {
            aCoder.encode(order, forKey: "order")
        }
        if parentChapterId != nil {
            aCoder.encode(parentChapterId, forKey: "parentChapterId")
        }
        if userControlSetTop != nil {
            aCoder.encode(userControlSetTop, forKey: "userControlSetTop")
        }
        if visible != nil {
            aCoder.encode(visible, forKey: "visible")
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
