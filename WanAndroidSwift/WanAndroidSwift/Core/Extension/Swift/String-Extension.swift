//
//  String-Extension.swift
//  HelloDouyu
//
//  Created by James on 2018/10/4.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

extension String {
    
    /// 计算文本的size
    ///
    /// - Parameters:
    ///     - constrainedSize：限制的size
    ///     - font:字号
    ///     - lineSpacing：默认为nil，使用系统默认的行间距
    /// - Returns: 待计算文本的size
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil) -> CGSize {
//        let attritube = NSMutableAttributedString(string: self)
//        let range = NSRange(location: 0, length: attritube.length)
//        attritube.addAttributes([NSAttributedString.Key.font: font], range: range)
//        if lineSpacing != nil {
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.lineSpacing = lineSpacing!
//            attritube.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
//        }
//
//        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
//        var size = rect.size
//
//        if let currentLineSpacing = lineSpacing {
//            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
//            let spacing = size.height - font.lineHeight
//            if spacing <= currentLineSpacing && spacing > 0 {
//                size = CGSize(width: size.width, height: font.lineHeight)
//            }
//        }
        
        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing, lines: 0)
        
        return size
    }
    
    /// 计算文本的size
    ///
    /// - Parameters:
    ///     - constrainedSize：限制的size
    ///     - font:字号
    ///     - lineSpacing：默认为nil，使用系统默认的行间距
    ///     - lines：限制的行数
    /// - Returns: 待计算文本的size
    func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize {
        if lines < 0 {
            return .zero
        }
        
//        let size = boundingRect(with: constrainedSize, font: font, lineSpacing: lineSpacing)
        let attritube = NSMutableAttributedString(string: self)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([NSAttributedString.Key.font: font], range: range)
        if lineSpacing != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing!
            attritube.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        let rect = attritube.boundingRect(with: constrainedSize, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size
        
        if let currentLineSpacing = lineSpacing {
            // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
            let spacing = size.height - font.lineHeight
            if spacing <= currentLineSpacing && spacing > 0 {
                size = CGSize(width: size.width, height: font.lineHeight)
            }
        }
        
        
        
        if lines == 0 {
            return size
        }
        
        let currentLineSpacing = (lineSpacing == nil) ? (font.lineHeight - font.pointSize) : lineSpacing!
        let maximumHeight = font.lineHeight*CGFloat(lines) + currentLineSpacing*CGFloat(lines - 1)
        if size.height >= maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        }
        
        return size
    }
}

extension String {
    
    /// Converting an array of strings by iterator
    /// e.g: "YinYu".stringToArr()   "["Y", "i", "n", "Y", "u"]"
    ///
    /// - Returns: [String]
    public func stringToArr() -> [String] {
        return PrefixSequence(string: self).map { $0 }
    }
    
    /// Converts an array of uppercase strings into iterators
    /// e.g: "YinYu".uppercasedArr()   "["Y", "I", "N", "Y", "U"]"
    ///
    /// - Returns: [String]
    public func uppercasedArr() -> [String] {
        return PrefixSequence(string: self).map { $0.uppercased() }
    }
    
    /// 截取第一个到第任意位置
    ///
    /// - Parameter end: 结束的位值
    /// - Returns: 截取后的字符串
    public func stringCut(end: Int) ->String{
        guard self.startIndex < self.endIndex else { return "截取超出范围" }
        let str = prefix(upTo: index(startIndex, offsetBy: end))
        return String(str)
    }
    
    /// 截取人任意位置到结束
    ///
    /// - Parameter end:
    /// - Returns: 截取后的字符串
    public func stringCutToEnd(star: Int) -> String {
        guard self.startIndex < self.endIndex else { return "截取超出范围" }
        let start = index(startIndex, offsetBy: star)
        return String(describing: [start...])
    }
    
    /// 字符串任意位置插入
    ///
    /// - Parameters:
    ///   - content: 插入内容
    ///   - locat: 插入的位置
    /// - Returns: 添加后的字符串
    public func stringInsert(content: String,locat: Int) -> String {
        guard self.startIndex < self.endIndex else { return "截取超出范围" }
        let str1 = stringCut(end: locat)
        let str2 = stringCutToEnd(star: locat)
        return str1 + content + str2
    }
    
    /// 计算字符串宽高
    ///
    /// - Parameter size: size
    /// - Returns: CGSize
    public func getStringSzie(size: CGFloat = 10) -> CGSize {
        let baseFont = UIFont.systemFont(ofSize: size)
        let size = self.size(withAttributes: [NSAttributedString.Key.font: baseFont])
        let width = ceil(size.width) + 5
        let height = ceil(size.height)
        return CGSize(width: width, height: height)
    }
    
    /// 字符串截取         3  6
    /// e.g let aaa = "abcdefghijklmnopqrstuvwxyz"  -> "cdef"
    /// - Parameters:
    ///   - start: 开始位置 3
    ///   - end: 结束位置 6
    /// - Returns: 截取后的字符串 "cdef"
    public func startToEnd(start: Int,end: Int) -> String {
        if !(end < self.count) || start > end { return "取值范围错误" }
        var tempStr: String = ""
        for i in start...end {
            let temp: String = self[self.index(self.startIndex, offsetBy: i - 1)].description
            tempStr += temp
        }
        return tempStr
    }
    
    /// 字符URL格式化
    ///
    /// - Returns: 格式化的 url
    public func stringEncoding() -> String {
        let url = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return url!
    }
}

//MARK:            ________________IteratorProtocol________________
public struct PrefixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index
    init(string: String) {
        self.string = string
        offset = string.startIndex
    }
    mutating public func next() -> String? {
        guard offset < string.endIndex else { return nil }
        let previous = offset
        offset = string.index(after: offset)
        return String(string[previous..<offset])
    }
}

public struct PrefixSequence: Sequence {
    let string: String
    public func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

