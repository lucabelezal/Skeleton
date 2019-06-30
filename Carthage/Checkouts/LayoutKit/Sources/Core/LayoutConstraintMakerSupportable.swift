//
//  LayoutConstraintMakerSupportable.swift
//  LayoutKit
//
//  Created by Vinicius França on 29/09/18.
//  Copyright © 2018 Vinicius França. All rights reserved.
//

import Foundation

public class LayoutConstraintMakerSupportable {

    internal let constant: LayoutConstraint?

    internal required init(constant: LayoutConstraint?) {
        self.constant = constant
    }

    @discardableResult
    public func priority(_ priority: LayoutPriortizable) -> LayoutConstraintMakerSupportable {
        guard let constant = constant else {
            return LayoutConstraintMakerSupportable(constant: self.constant)
        }
        constant.priority = priority.priorityValue
        return LayoutConstraintMakerSupportable(constant: constant)
    }

    @discardableResult
    public func reference(_ reference: inout LayoutConstraint?) -> LayoutConstraintMakerSupportable {
        reference = constant
        return LayoutConstraintMakerSupportable(constant: constant)
    }

    @discardableResult
    public func insetSafeArea(_ inset: LayoutEdgeInsets) -> LayoutConstraintMakerSupportable {
        guard let constant = constant else {
            return LayoutConstraintMakerSupportable(constant: self.constant)
        }
        constant.constant += inset.safeAreaInset
        return LayoutConstraintMakerSupportable(constant: constant)
    }

}
