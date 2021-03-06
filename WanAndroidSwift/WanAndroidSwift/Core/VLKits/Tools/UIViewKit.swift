//
//  UIViewKit.swift
//  HelloSwiftKits
//
//  Created by James on 2021/3/1.
//

import UIKit
/// 加载 xib 内的 UIView
///
/// - Parameters:
///   - name: the UIStoryboard Name
///   - indentifier: UIStoryboard  Indentifier
/// - Returns: UIViewController
func xibLoad(name: String) -> View? {
    let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.last as? UIView
    return view
}

/// 屏幕尺寸
///
/// - Returns: 屏幕尺寸
func screenSize() -> CGSize {
    return UIScreen.main.bounds.size
}

/// 加载 StoryBoard 内的 UIViewController
///
/// - Parameters:
///   - name: UIStoryboard Name
///   - indentifier: StoryBoard Indentifier
/// - Returns: UIViewController
func storyBoard(name: String, indentifier: String) -> UIViewController {
    return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: indentifier)
}

/// 直接加载 StoryBoard
///
/// - Parameter forStoryboardName: StoryBoard Name
/// - Returns: StoryBoard VC
public func viewController(forStoryboardName: String) -> UIViewController {
    return UIStoryboard(name: forStoryboardName, bundle: nil).instantiateInitialViewController()!
}

/// image 安全不崩溃的命名原则
class TemplateImageView: ImageView {
    @IBInspectable var templateImage: Image? {
        didSet {
            image = templateImage?.withRenderingMode(.alwaysTemplate)
        }
    }
}

/// 设置顶部电池栏的颜色
///
/// - Parameter black: 黑色或者白色
public func viewTopStaus(black: Bool) {
    var barStyle: UIStatusBarStyle = .default
    switch black {
    case true:
        barStyle = .default
    default:
        barStyle = .lightContent
    }
    UIApplication.shared.statusBarStyle = barStyle
}

/// 设置背景渐变
///
/// - Parameters:
///   - begin: 开始的颜色 0x123456
///   - end: 结束的颜色 0X123456
///   - frame: 所加的背景的范围
/// - Returns: CAGradientLayer
public func bkShadeColor(begin: Int,end: Int, frame: CGRect) -> CAGradientLayer {
    let layer = CAGradientLayer()
    layer.colors = [Color(hex: begin).cgColor,Color(hex: end).cgColor]
    layer.frame = frame
    return layer
}

/// 设置透明导航栏
///
/// - Parameter nav:
public func navigationLayerShade(nav: UINavigationController) {
    nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
    nav.navigationBar.shadowImage = UIImage()
}

/// 设置导航栏的颜色
///
/// - Parameters:
///   - nav: 导航栏控制器
///   - color: 颜色
public func setNavigationColor(nav: UINavigationController,color: Color) {
    let image = Image(color: Color(hex: 0x58101D), size: CGSize(width: screenWidth, height: 64))
    nav.navigationBar.setBackgroundImage(image, for: .default)
    nav.navigationBar.shadowImage = Image()
}
