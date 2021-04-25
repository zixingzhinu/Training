//
//  Utility.swift
//  HelloSwiftKits
//
//  Created by James on 2021/3/1.
//

import UIKit

#if os(iOS)

/// 线程加锁
///
/// - Parameters:
///   - lock: 加锁对象
///   - dispose: 执行闭包函数,
public func synchronized(_ lock: AnyObject,dispose: ()->()) {
    objc_sync_enter(lock)
    dispose()
    objc_sync_exit(lock)
}


//MARK:            延时使用        _____________________________________________________________________________

public typealias TaskBlock = (_ cancel : Bool) -> Void

public func delay(_ time: TimeInterval, task: @escaping ()->()) ->  TaskBlock? {
    
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    
    var closure: (()->Void)? = task
    var result: TaskBlock?
    
    let delayedClosure: TaskBlock = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}

public func cancel(_ task: TaskBlock?) {
    task?(true)
}
#endif
