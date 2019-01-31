//
//  StarsEmitterView.swift
//  HelloDouyu
//
//  Created by James on 2019/1/26.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import UIKit

class StarsEmitterView: UIView, Stars {

    override init(frame: CGRect) {
        super.init(frame: frame)
//        createStarsWithSel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    override func didMoveToWindow() {
        if self.superview != nil {
            createStarsWithSelf()
        }
    }
    
}
