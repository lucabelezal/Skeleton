//
//  LayoutConstraintMakerRelatable.swift
//  LayoutKit
//
//  Created by Vinicius França on 29/09/18.
//  Copyright © 2018 Vinicius França. All rights reserved.
//

import CoreGraphics
import Foundation

public protocol LayoutConstraintMakerRelatable {
    func equalTo(_ item: LayoutConstraintItemable, constant: CGFloat) -> LayoutConstraintMakerSupportable
    func equalTo(constant: CGFloat) -> LayoutConstraintMakerSupportable
    func greaterThanOrEqualTo(_ item: LayoutConstraintItemable, constant: CGFloat) -> LayoutConstraintMakerSupportable
    func greaterThanOrEqualTo(constant: CGFloat) -> LayoutConstraintMakerSupportable
    func lessThanOrEqualTo(_ item: LayoutConstraintItemable, constant: CGFloat) -> LayoutConstraintMakerSupportable
    func lessThanOrEqualTo(constant: CGFloat) -> LayoutConstraintMakerSupportable
}
