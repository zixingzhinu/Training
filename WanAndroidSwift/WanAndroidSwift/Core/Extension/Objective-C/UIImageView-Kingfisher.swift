//
//  UIImageView-Kingfisher.swift
//  HelloDouyu
//
//  Created by James on 2019/1/22.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ URLString: String?, _ placeHolderName: String?) {
        guard let URLString = URLString else { return }
        guard let placeHolderName = placeHolderName else { return }
        guard let url = URL(string: URLString) else { return }
        kf.setImage(with: url, placeholder: UIImage(named: placeHolderName))
    }
}
