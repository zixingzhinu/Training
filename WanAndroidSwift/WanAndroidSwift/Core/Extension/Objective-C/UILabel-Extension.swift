//
//  UILabel-Extension.swift
//  HelloDouyu
//
//  Created by James on 2018/10/4.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// ## 判断文本标签的内容是否被截断
    /// ### 增加一个 isTruncated 属性来表示当前内容是否被截断。其内部逻辑就是比较下面两种行数的大小：
    /// 1. 所有文字如果要完全显示的话需要的行数
    /// 2. 实际能显示的行数
    var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }
        
        //计算理论上显示所有文字需要的尺寸
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelTextSize = (labelText as NSString)
            .boundingRect(with: rect, options: .usesLineFragmentOrigin,
                          attributes: [NSAttributedString.Key.font: self.font], context: nil)
        
        //计算理论上需要的行数
        let labelTextLines = Int(ceil(CGFloat(labelTextSize.height) / self.font.lineHeight))
        
        //实际可显示的行数
        var labelShowLines = Int(floor(CGFloat(bounds.size.height) / self.font.lineHeight))
        if self.numberOfLines != 0 {
            labelShowLines = min(labelShowLines, self.numberOfLines)
        }
        
        //比较两个行数来判断是否需要截断
        return labelTextLines > labelShowLines
    }
    
    /// 设置`numberOfLines = 0`的原因：
    /// 配合方法`func boundingRect(with constrainedSize: CGSize, font: UIFont, lineSpacing: CGFloat? = nil, lines: Int) -> CGSize`使用，可以很好的解决不能正常显示限制行数的问题；
    /// 如果为label设置了限制行数（大于0的前提），使用上面的计算方法（带行间距），同时字符串的实际行数大于限制行数，这时候的高度会使label不能正常显示。
    /// ## 设置文本
    ///
    /// - Parameters:
    ///   - normalString: 文本
    ///   - lineSpacing: 行距
    ///   - frame: frame
    func setText(with normalString: String, lineSpacing: CGFloat?, frame: CGRect) {
        self.frame = frame
        self.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        if lineSpacing != nil {
            if (frame.height - font.lineHeight) <= lineSpacing! {
                paragraphStyle.lineSpacing = 0
            } else {
                paragraphStyle.lineSpacing = lineSpacing!
            }
        }
        let attributedString = NSMutableAttributedString(string: normalString)
        let range = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttributes([NSAttributedString.Key.font: font], range: range)
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        
        self.attributedText = attributedString
    }
}
