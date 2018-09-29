//
//  UIColor-Extension.swift
//  HelloDouyu
//
//  Created by James on 2018/9/29.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(rede: CGFloat, greene: CGFloat, bluee: CGFloat, alphae: CGFloat = 1.0) {
        self.init(red: rede/255.0, green: greene/255.0, blue: bluee/255.0, alpha: alphae)
    }
}
