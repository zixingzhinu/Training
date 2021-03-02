//
//  TextKit.swift
//  HelloSwiftKits
//
//  Created by James on 2021/3/1.
//

import UIKit

/// Seting AttributedString
///
/// - Parameters:
///   - color: 颜色 Arry [[Ox000000],[Ox000000]]
///   - content: 内容 Arry ["第一个"，"第二个"]
///   - size: 字体 Arry  [size1,size2]
/// - Returns: 富文本
public func setAttribute(color: [[Int]],content:[String],size: [CGFloat])-> NSMutableAttributedString {
    let str = NSMutableAttributedString()
    for i in 0..<color.count {
        str.append(NSAttributedString(string: content[i], attributes: [.foregroundColor: UIColor(hex: color[i][0]), .font:UIFont.systemFont(ofSize: size[i])]))
    }
    return str
}

/// scientific Notation Transition Normal String
/// 9.0006e+07  Transition   90,006,000
/// - Parameter f_loat: Input
/// - Returns: Output
public func inputFOutputS(f_loat: Double) -> String {
    let numFormat = NumberFormatter()
    numFormat.numberStyle = NumberFormatter.Style.decimal
    let num = NSNumber.init(value: f_loat)
    return numFormat.string(from: num)!
}

public func getNSStringSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: UIFont, w: CGFloat, h: CGFloat) -> CGSize {
    if str != nil {
        let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
        return strSize
    }
    
    if attriStr != nil {
        let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
        return strSize
    }
    
    return CGSize.zero
    
}

public func getNormalStrH(str: String, strFont: UIFont, w: CGFloat) -> CGFloat {
    return getNSStringSize(str: str, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
}

public func getNormalStrW(str: String, strFont: UIFont, h: CGFloat) -> CGFloat {
    return getNSStringSize(str: str, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
}

public func getAttributedStrH(attriStr: NSMutableAttributedString, strFont: UIFont, w: CGFloat) -> CGFloat {
    return getNSStringSize(attriStr: attriStr, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
}

public func getAttributedStrW(attriStr: NSMutableAttributedString, strFont: UIFont, h: CGFloat) -> CGFloat {
    return getNSStringSize(attriStr: attriStr, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
}
