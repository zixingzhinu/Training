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
        print(say(text: "I'm coming"))
    }
    
    /// 测试方法，测试是否可以重写协议的方法，以及如何执行，没有实际意义。
    ///
    /// - Parameter text: text description
    /// - Returns: return value description
    func say(text: String) -> String {
        return "I said:\(text)!!!"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    override func didMoveToWindow() {
        if self.superview != nil {
//            createStarsWithSelf()
        }
    }
    
    func startAnim() {
        createStarsWithSelf()
    }
    
    func stopAnim() {
//        stop()
        dismiss()
    }
    
    func dismiss() {
        removeFromSuperview()
    }
    
}
