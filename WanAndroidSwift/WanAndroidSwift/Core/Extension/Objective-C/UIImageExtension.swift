//
//  UIImageExtension.swift
//  HelloSwiftKits
//
//  Created by James on 2019/7/28.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

public extension UIImage {
    
    
    /// Swift 图片添加水印（因为水印位置颜色等不同，需要根据需求进行定制，可以借鉴该方法）
    /// - Parameters:
    ///   - originalImage: 原始图片
    ///   - icon: icon
    ///   - title: title
    ///   - markFont: 字体
    ///   - markColor: 颜色
    /// - Returns:
    func getWaterMark(_ originalImage: UIImage?,icon:UIImage?, title: String, andMark markFont: UIFont, andMark markColor: UIColor) -> UIImage? {
                let HORIZONTAL_SPACE: CGFloat = 130
                let VERTICAL_SPACE: CGFloat = 150
                var font: UIFont? = markFont
                if font == nil {
                    font = UIFont.systemFont(ofSize: 23)
                }
                var color: UIColor? = markColor
                if color == nil {
                    color = UIColor.blue
                }
                //原始image的宽高
                guard let viewWidth = originalImage?.size.width, let viewHeight = originalImage?.size.height else { return nil }
                //为了防止图片失真，绘制区域宽高和原始图片宽高一样
                UIGraphicsBeginImageContext(CGSize(width: viewWidth, height: viewHeight))
                //先将原始image绘制上
                originalImage?.draw(in: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
                //sqrtLength：原始image的对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
                let sqrtLength = sqrt(viewWidth * viewWidth + viewHeight * viewHeight)
                let attrStr = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : markColor, NSAttributedString.Key.font: markFont])
                //绘制文字的宽高
                let strWidth = attrStr.size().width
                let strHeight = attrStr.size().height
                
                //开始旋转上下文矩阵，绘制水印文字
                let context = UIGraphicsGetCurrentContext()
                
                //将绘制原点（0，0）调整到源image的中心
                context?.concatenate(CGAffineTransform(translationX: viewWidth / 2, y: viewHeight / 2))
                //以绘制原点为中心旋转
                context?.concatenate(CGAffineTransform(rotationAngle: CGFloat(Double.pi / 7.0)))
                //将绘制原点恢复初始值，保证当前context中心和源image的中心处在一个点(当前context已经旋转，所以绘制出的任何layer都是倾斜的)
                context?.concatenate(CGAffineTransform(translationX: -viewWidth / 2, y: -viewHeight / 2))
                
                //计算需要绘制的列数和行数
                let horCount: Int = Int(sqrtLength / CGFloat(strWidth + HORIZONTAL_SPACE)) + 1
                let verCount: Int = Int(sqrtLength / CGFloat(strHeight + VERTICAL_SPACE)) + 1
                //此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
                let orignX: CGFloat = -(sqrtLength - viewWidth) / 2
                let orignY: CGFloat = -(sqrtLength - viewHeight) / 2
                //在每列绘制时X坐标叠加
                var tempOrignX: CGFloat = orignX
                //在每行绘制时Y坐标叠加
                var tempOrignY: CGFloat = orignY
                let iconW = icon != nil ? strHeight : 0
                let iconL = iconW == 0 ? 0 : iconW + 5
                for i in 0..<horCount * verCount {
                    if icon != nil {
                        icon?.draw(in: CGRect(x: tempOrignX, y: tempOrignY, width: strHeight, height: strHeight), blendMode: CGBlendMode.hardLight, alpha: 0.9)
                    }
                    title.draw(in: CGRect(x: tempOrignX+iconL, y: tempOrignY, width: strWidth, height: strHeight), withAttributes: [NSAttributedString.Key.foregroundColor : markColor, NSAttributedString.Key.font: markFont])
                    if i % horCount == 0 && i != 0 {
                        tempOrignX = orignX + ( i%2 == 0 ? (strWidth+HORIZONTAL_SPACE)*0.5 : 0)//是否隔行错开
                        tempOrignY += strHeight + VERTICAL_SPACE
                    } else {
                        tempOrignX += strWidth + HORIZONTAL_SPACE
                    }
                }
                //根据上下文制作成图片
                let finalImg: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return finalImg
            }
    
}
