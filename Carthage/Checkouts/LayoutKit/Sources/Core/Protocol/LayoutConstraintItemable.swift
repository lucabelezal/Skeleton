//
//  LayoutConstraintItemable.swift
//  LayoutKit
//
//  Created by Vinicius França on 29/09/18.
//  Copyright © 2018 Vinicius França. All rights reserved.
//

import Foundation

public protocol LayoutConstraintItemable { }

internal protocol LayoutConstraintItemConfigurable {
    var attribute: LayoutAttribute { get }
    var view: LayoutView { get }
    var isSafeArea: Bool { get }
}
