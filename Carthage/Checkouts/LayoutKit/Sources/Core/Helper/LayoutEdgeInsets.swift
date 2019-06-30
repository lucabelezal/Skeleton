//
//  LayoutEdgeInsets.swift
//  LayoutKit
//
//  Created by Vinicius França on 30/09/18.
//  Copyright © 2018 Vinicius França. All rights reserved.
//

import CoreGraphics
import UIKit

public enum LayoutEdgeInsets {
    case bottom
    case left
    case right
    case top

    internal var safeAreaInset: CGFloat {
        switch self {
        case .bottom:
            guard let windowDelegate = UIApplication.shared.delegate?.window, let window = windowDelegate, #available(iOS 11, *) else {
                return CGFloat()
            }
            return window.safeAreaInsets.bottom
        case .left:
            guard let windowDelegate = UIApplication.shared.delegate?.window, let window = windowDelegate, #available(iOS 11, *) else {
                return CGFloat()
            }
            return window.safeAreaInsets.left
        case .right:
            guard let windowDelegate = UIApplication.shared.delegate?.window, let window = windowDelegate, #available(iOS 11, *) else {
                return CGFloat()
            }
            return window.safeAreaInsets.right
        case .top:
            guard let windowDelegate = UIApplication.shared.delegate?.window, let window = windowDelegate, #available(iOS 11, *) else {
                return CGFloat()
            }
            return window.safeAreaInsets.top
        }
    }

}
