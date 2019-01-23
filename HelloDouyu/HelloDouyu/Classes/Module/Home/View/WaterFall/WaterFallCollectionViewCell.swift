//
//  WaterFallCollectionViewCell.swift
//  HelloDouyu
//
//  Created by James on 2019/1/22.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

class WaterFallCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var audienceNumberButton: UIButton!
    
    var waterFallModel: WaterFallModel? {
        didSet {
            avatarImageView.setImage(waterFallModel!.isEvenIndex ? waterFallModel?.pic51 : waterFallModel?.pic74, "home_pic_default")
            liveImageView.isHidden = waterFallModel?.live == 0
            nicknameLabel.text = waterFallModel?.name
            audienceNumberButton.setTitle("\(waterFallModel?.focus ?? 0)", for: .normal)
        }
    }
}
