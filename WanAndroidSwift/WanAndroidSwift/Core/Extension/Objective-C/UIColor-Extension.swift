//
//  UIColor-Extension.swift
//  HelloDouyu
//
//  Created by James on 2018/9/29.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit


extension UIColor {
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    /// 根据16进制整型颜色值获取UIColor
    ///
    /// - Parameter rgbValue: 16进制整型颜色值(如：0x209624)
    /// - Returns: UIColor
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /// 对UIColor()的构造函数生成的对象进行解析（类似于UIColor提供的getRed()系列API）
    ///
    /// - Parameter color: UIColor对象  注：必须由UIColor()的构造函数生成
    /// - Returns: 返回对应的R G B A值
    func getRGBValue() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        guard let components = self.cgColor.components else {
            fatalError("文字颜色请按照RGB方式设置")
        }
        return (components[0] * 255, components[1] * 255, components[2] * 255, components[3] * 255)
    }
    
    /// 对UIColor对象进行解析
    ///
    /// - Returns: 返回对应的R G B A值
    func getRGBAValue() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) { //这里也可以直接返回（CGFloat, CGFloat, CGFloat, CGFloat）
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
}

//MARK:            Convenience methods for UIColor        _________________________________________________________________________________________________
public extension UIColor {
    
    /// Init color without divide 255.0
    ///
    /// - Parameters:
    ///   - r: (0 ~ 255) red
    ///   - g: (0 ~ 255) green
    ///   - b: (0 ~ 255) blue
    ///   - a: (0 ~ 1) alpha
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
    }
    
    /// Init color without divide 255.0
    ///
    /// - Parameters:
    ///   - r: (0 ~ 255) red
    ///   - g: (0 ~ 255) green
    ///   - b: (0 ~ 1) alpha
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r: r, g: g, b: b, a: 1)
    }
    
    /// Init color with hex code
    ///
    /// - Parameter hex: hex code (eg. 0x00eeee)
    convenience init(hex: Int) {
        self.init(r: (hex & 0xff0000) >> 16, g: (hex & 0xff00) >> 8, b: (hex & 0xff), a: 1)
    }
    
    /// Init color with hex code
    ///
    /// - Parameter hex: hex code (eg. 0x00eeee)
    convenience init(hex: Int, a: CGFloat=1) {
        self.init(r: (hex & 0xff0000) >> 16, g: (hex & 0xff00) >> 8, b: (hex & 0xff), a: a)
    }
    
}


