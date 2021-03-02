//
//  DictionaryExtension.swift
//  HelloSwiftKits
//
//  Created by James on 2019/7/28.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import Foundation
public extension Dictionary {
    
    /// Merge two dictionaries, and the merged dictionary will overwrite duplicate keys
    /// e.g:
    ///    var defaultDic: [String: String] = ["Yin": "x"]
    ///    let dic: [String: String]  = ["Yin": "Yu"]
    ///    defaultDic.merge(dic) "["Yin": "Yu"]"
    ///    let otherDic = ["Yu": "Ge"]
    ///    defaultDic.merge(otherDic) "["Yin": "Yu","Yu": "Ge"]"
    ///
    /// - Parameter other: [Any: AnyObject]
    mutating func merge<S>(_ other: S)
        where S: Sequence, S.Iterator.Element == (key: Key, value: Value) {
            for (k,v) in other {
                self[k] = v
            }
    }
    
    ///  Create a dictionary from a sequence of (Key, Value) key pairs
    ///    let defaultName = (1..<6).map { (key: "YinYu\($0)", value: false) }
    ///    "[(key: "YinYu1", value: false), (key: "YinYu2", value: false), (key: "YinYu3", value: false), (key: "YinYu4", value: false), (key: "YinYu5", value: false)]"
    ///    let nameDictionary = Dictionary(defaultName)
    ///    "["YinYu5": false, "YinYu1": false, "YinYu3": false, "YinYu2": false, "YinYu4": false]"
    init<S: Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            self = [:]
            self.merge(sequence)
    }
    
    /// As a result, the dictionary structure is maintained and mapped only to its values.
    /// You can combine one dictionary into another. In addition, the method parameters can also be key values, arrays, or any of the same arbitrary sequence, rather than having to be a dictionary.
    /// e.g： var dics = ["Yin": 66,"Yu": 99]
    ///       let tranDic = dics.mapValues { str in
    ///           return String(str)
    ///       }
    ///    print(tranDic)   "["Yu": "99", "Yin": "66"]"
    /// - Parameter transform: transform: (Value) -> NewValue)
    /// - Returns: (key, transform(value))
    func mapValues<NewValue>(transform: (Value) -> NewValue)
        -> [Key: NewValue] {
            return Dictionary<Key, NewValue>(map{ (key, value) in
                return (key, transform(value))
            })
    }
}
