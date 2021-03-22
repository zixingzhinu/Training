//
//  PKHUDExtension.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/11.
//

import PKHUD

extension HUD {
    static func show() {
        show(.labeledProgress(title: nil, subtitle: nil))
//        let contentView = PKHUD.sharedHUD.contentView as! PKHUDSquareBaseView
//        contentView.subtitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
//        contentView.subtitleLabel.textColor = UIColor.black.withAlphaComponent(0.85)
    }
}
