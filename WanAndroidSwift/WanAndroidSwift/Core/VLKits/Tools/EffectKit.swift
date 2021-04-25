//
//  EffectKit.swift
//  HelloSwiftKits
//
//  Created by James on 2021/3/1.
//

import UIKit

/// 短震
public func shortShockEffect() {
    if #available(iOS 10.0, *) {
        let generator = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle.light)
        generator.prepare()
        generator.impactOccurred()
    } else {
        // Fallback on earlier versions
    }
}
