//
//  VLNetConstants.swift
//  HelloSwiftKits
//
//  Created by James on 2020/5/18.
//  Copyright © 2020 FinupCredit. All rights reserved.
//  常量

import Foundation

enum VLNetStatusCode: Int {
    case StatusCode_200 = 200
    case StatusCode_401 = 401
    case StatusCode_500 = 500
    case StatusCode_11114 = 11114
}

/// timeout
let timeoutIntervalForRequest: TimeInterval = 60

typealias SuccessClosure<M: Decodable> = (M?) -> Void
typealias FailureClosure = (Error) -> Void
