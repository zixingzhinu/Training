//
//  MyUILabel.swift
//  WanAndroidSwift
//
//  Created by James on 2021/4/6.
//

import UIKit

class MyUILabel: UILabel {

    var textInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        guard let _ = text else { return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines) }
        let originalRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)
        return originalRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
