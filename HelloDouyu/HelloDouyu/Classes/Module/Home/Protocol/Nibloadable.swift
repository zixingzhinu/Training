//
//  Nibloadable.swift
//  HelloDouyu
//
//  Created by James on 2019/3/11.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

protocol Nibloadable {
    
}

extension Nibloadable where Self: UIView {
    static func loadFromNib(nibName: String? = nil) -> Self {
        let tmpNibName = nibName == nil ? "\(self)" : nibName!
        return Bundle.main.loadNibNamed(tmpNibName, owner: nil, options: nil)?.first as! Self
    }
}
