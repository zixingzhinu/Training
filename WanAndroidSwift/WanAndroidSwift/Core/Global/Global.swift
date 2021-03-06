//
//  Global.swift
//  Hello
//
//  Created by James on 2018/9/30.
//  Copyright © 2018 FinupCredit. All rights reserved.
//

#if os(macOS)
import Cocoa
#elseif os(watchOS)
import WatchKit
#else
import UIKit
#endif

#if os(macOS)
import AppKit
public typealias Image = NSImage
public typealias View = NSView
public typealias Color = NSColor
public typealias ImageView = NSImageView
public typealias Button = NSButton
#elseif os(iOS)
import UIKit
public typealias Image = UIImage
public typealias ImageView = UIImageView
public typealias Color = UIColor
public typealias View = UIView
public typealias Screen = UIScreen
public typealias Font = UIFont
public typealias Event = UIEvent
public typealias Touch = UITouch
public typealias DisplayLink = CADisplayLink
public typealias ScrollView = UIScrollView
public typealias Gesture = UIGestureRecognizer
public typealias GestureState = UIGestureRecognizer.State
public typealias GestureDelegate = UIGestureRecognizerDelegate
public typealias TapGesture = UITapGestureRecognizer
public typealias PanGesture = UIPanGestureRecognizer
public typealias PinchGesture = UIPinchGestureRecognizer
public typealias RotationGesture = UIRotationGestureRecognizer

public final class Aphrodite<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}
#endif


let screenBounds = UIScreen.main.bounds
let screenWidth = screenBounds.width
let screenheight = screenBounds.height
let statusBarHeight = UIApplication.shared.statusBarFrame.height




