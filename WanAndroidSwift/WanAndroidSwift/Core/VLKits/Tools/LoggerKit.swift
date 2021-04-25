//
//  LoggerKit.swift
//  HelloSwiftKits
//
//  Created by James on 2021/3/1.
//

import UIKit

#if os(iOS)
/// 自定义Debug模式打印
///
///     | 符号 | 类型 | 描述 |
///     | --- | --- | --- |
///     | #file | String | 包含这个符号的文件的路径 |
///     | #line | Int | 符号出现处的行号 |
///     | #column | Int | 符号出现处的列 |
///     | #function | String | 包含这个符号的方法名字 |
public func printDebug<T>(_ message: T,
                          file: String = #file,
                          method: String = #function,
                          line: Int = #line
    )
{
    #if DEBUG
    print("------------------\(line) lineBegin-------------------------\nClass Name: \((file as NSString).lastPathComponent)\nMethod Name: \(method)\nMessage: \(message)\n------------------\(line) line  End-------------------------")
    #endif
}

/// 自定义Debug模式打印
///
///     | 符号 | 类型 | 描述 |
///     | --- | --- | --- |
///     | #file | String | 包含这个符号的文件的路径 |
///     | #line | Int | 符号出现处的行号 |
///     | #column | Int | 符号出现处的列 |
///     | #function | String | 包含这个符号的方法名字 |
public func printDebug(_ items: Any...,
    separator: String = " ",
    terminator: String = "\n",
    file: String = #file,
    method: String = #function,
    line: Int = #line) {
    #if DEBUG
    for item in items {
        print("------------------\(line) lineBegin-------------------------\nClass Name: \((file as NSString).lastPathComponent)\nMethod Name: \(method)\nMessage: \(item)\n------------------\(line) line  End-------------------------", separator: separator, terminator: terminator)
    }
    #endif
}

public func OKPrint( _ object: @autoclosure() -> Any?,
                     _ file: String = #file,
                     _ function: String = #function,
                     _ line: Int = #line) {
    #if DEBUG
    guard let value = object() else {
        return
    }
    var stringRepresentation: String?
    if let value = value as? CustomDebugStringConvertible {
        stringRepresentation = value.debugDescription
    }
    else if let value = value as? CustomStringConvertible {
        stringRepresentation = value.description
    }
    else {
        fatalError("gLog only works for values that conform to CustomDebugStringConvertible or CustomStringConvertible")
    }
    let gFormatter = DateFormatter()
    gFormatter.dateFormat = "HH:mm:ss:SSS"
    let timestamp = gFormatter.string(from: Date())
    let queue = Thread.isMainThread ? "UI" : "BG"
    let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"
    if let string = stringRepresentation {
        print("✅ \(timestamp) {\(queue)} \(fileURL) > \(function)[\(line)]: \(string)")
    } else {
        print("✅ \(timestamp) {\(queue)} \(fileURL) > \(function)[\(line)]: \(value)")
    }
    #endif
}


#endif
