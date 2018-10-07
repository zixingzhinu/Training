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


