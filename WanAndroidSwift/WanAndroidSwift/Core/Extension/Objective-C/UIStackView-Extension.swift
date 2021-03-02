//
//  UIStackView-Extension.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/9.
//  Copyright © 2020 FinupCredit. All rights reserved.
//

import UIKit

extension UIStackView {
    /// 兼容iOS11之前版本，进行自定义边距设置
    /// How can I create UIStackView with variable spacing between views?
    func addCustomSpacing(_ spacing: CGFloat, after arrangedSubview: UIView) {
        if #available(iOS 11.0, *) {
            self.setCustomSpacing(spacing, after: arrangedSubview)
        } else {
            let separatorView = UIView(frame: .zero)
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            switch axis {
            case .horizontal:
                separatorView.widthAnchor.constraint(equalToConstant: spacing).isActive = true
            case .vertical:
                separatorView.heightAnchor.constraint(equalToConstant: spacing).isActive = true
            }
            if let index = self.arrangedSubviews.firstIndex(of: arrangedSubview) {
                insertArrangedSubview(separatorView, at: index + 1)
            }
        }
    }
}
