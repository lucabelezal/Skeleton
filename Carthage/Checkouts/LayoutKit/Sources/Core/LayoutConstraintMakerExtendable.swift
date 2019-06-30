//
//  LayoutConstraintMakerExtendable.swift
//  LayoutKit
//
//  Created by Vinicius França on 29/09/18.
//  Copyright © 2018 Vinicius França. All rights reserved.
//

import CoreGraphics
import Foundation

public class LayoutConstraintMakerExtendable {

    internal let view: LayoutView
    internal let attribute: LayoutAttribute

    internal required init(view: LayoutView, attribute: LayoutAttribute) {
        self.view = view
        self.attribute = attribute
    }

    internal func configureView(_ constraintType: LayoutConstraintType, constant: CGFloat, layout: LayoutConstraintItemable) -> LayoutConstraint {

        guard let layoutConfiguration = layout as? LayoutConstraintItemConfigurable else {
            fatalError("LayoutItem not implement LayoutConstraintItemConfigurable")
        }

        switch attribute {
        case .left:
            if constraintType == .equalTo {
                return view.leftAnchor.constraint(equalTo: configure(layoutX: layoutConfiguration), constant: constant)
            } else if constraintType == .greaterThanOrEqualTo {
                return view.leftAnchor.constraint(greaterThanOrEqualTo: configure(layoutX: layoutConfiguration), constant: constant)
            } else {
                return view.leftAnchor.constraint(lessThanOrEqualTo: configure(layoutX: layoutConfiguration), constant: constant)
            }
        case .right:
            if constraintType == .equalTo {
                return view.rightAnchor.constraint(equalTo: configure(layoutX: layoutConfiguration), constant: constant)
            } else if constraintType == .greaterThanOrEqualTo {
                return view.rightAnchor.constraint(greaterThanOrEqualTo: configure(layoutX: layoutConfiguration), constant: constant)
            } else {
                return view.rightAnchor.constraint(lessThanOrEqualTo: configure(layoutX: layoutConfiguration), constant: constant)
            }
        case .top:
            if constraintType == .equalTo {
                return view.topAnchor.constraint(equalTo: configure(layoutY: layoutConfiguration), constant: constant)
            } else if constraintType == .greaterThanOrEqualTo {
                return view.topAnchor.constraint(greaterThanOrEqualTo: configure(layoutY: layoutConfiguration), constant: constant)
            } else {
                return view.topAnchor.constraint(lessThanOrEqualTo: configure(layoutY: layoutConfiguration), constant: constant)
            }
        case .bottom:
            if constraintType == .equalTo {
                return view.bottomAnchor.constraint(equalTo: configure(layoutY: layoutConfiguration), constant: constant)
            } else if constraintType == .greaterThanOrEqualTo {
                return view.bottomAnchor.constraint(greaterThanOrEqualTo: configure(layoutY: layoutConfiguration), constant: constant)
            } else {
                return view.bottomAnchor.constraint(lessThanOrEqualTo: configure(layoutY: layoutConfiguration), constant: constant)
            }
        case .width:
            if constraintType == .equalTo {
                return view.widthAnchor.constraint(equalTo: configure(dimension: layoutConfiguration), constant: constant)
            } else if constraintType == .greaterThanOrEqualTo {
                return view.widthAnchor.constraint(greaterThanOrEqualTo: configure(dimension: layoutConfiguration), constant: constant)
            } else {
                return view.widthAnchor.constraint(lessThanOrEqualTo: configure(dimension: layoutConfiguration), constant: constant)
            }
        case .height:
            if constraintType == .equalTo {
                return view.heightAnchor.constraint(equalTo: configure(dimension: layoutConfiguration), constant: constant)
            } else if constraintType == .greaterThanOrEqualTo {
                return view.heightAnchor.constraint(greaterThanOrEqualTo: configure(dimension: layoutConfiguration), constant: constant)
            } else {
                return view.heightAnchor.constraint(lessThanOrEqualTo: configure(dimension: layoutConfiguration), constant: constant)
            }
        case .centerY:
            if constraintType == .equalTo {
                return view.centerYAnchor.constraint(equalTo: configure(layoutY: layoutConfiguration), constant: constant)
            } else if constraintType == .greaterThanOrEqualTo {
                return view.centerYAnchor.constraint(greaterThanOrEqualTo: configure(layoutY: layoutConfiguration), constant: constant)
            } else {
                return view.centerYAnchor.constraint(lessThanOrEqualTo: configure(layoutY: layoutConfiguration), constant: constant)
            }
        case .centerX:
            if constraintType == .equalTo {
                return view.centerXAnchor.constraint(equalTo: configure(layoutX: layoutConfiguration), constant: constant)
            } else if constraintType == .greaterThanOrEqualTo {
                return view.centerXAnchor.constraint(greaterThanOrEqualTo: configure(layoutX: layoutConfiguration), constant: constant)
            } else {
                return view.centerXAnchor.constraint(lessThanOrEqualTo: configure(layoutX: layoutConfiguration), constant: constant)
            }
        case .leading:
            if constraintType == .equalTo {
                return view.leadingAnchor.constraint(equalTo: configure(layoutX: layoutConfiguration), constant: constant)
            } else if constraintType == .greaterThanOrEqualTo {
                return view.leadingAnchor.constraint(greaterThanOrEqualTo: configure(layoutX: layoutConfiguration), constant: constant)
            } else {
                return view.leadingAnchor.constraint(lessThanOrEqualTo: configure(layoutX: layoutConfiguration), constant: constant)
            }
        case .trailing:
            if constraintType == .equalTo {
                return view.trailingAnchor.constraint(equalTo: configure(layoutX: layoutConfiguration), constant: constant)
            } else if constraintType == .greaterThanOrEqualTo {
                return view.trailingAnchor.constraint(greaterThanOrEqualTo: configure(layoutX: layoutConfiguration), constant: constant)
            } else {
                return view.trailingAnchor.constraint(lessThanOrEqualTo: configure(layoutX: layoutConfiguration), constant: constant)
            }
        default:
            fatalError("Layout attribute not implemented (Yet!)")
        }
    }

}

internal extension LayoutConstraintMakerExtendable {

    func configure(layoutX item: LayoutConstraintItemConfigurable) -> LayoutXAnchor {
        switch item.attribute {
        case .left:
            if #available(iOS 11.0, *), item.isSafeArea {
                return item.view.safeAreaLayoutGuide.leftAnchor
            }
            return item.view.leftAnchor
        case .right:
            if #available(iOS 11.0, *), item.isSafeArea {
                return item.view.safeAreaLayoutGuide.rightAnchor
            }
            return item.view.rightAnchor
        case .centerX:
            if #available(iOS 11.0, *), item.isSafeArea {
                return item.view.safeAreaLayoutGuide.centerXAnchor
            }
            return item.view.centerXAnchor
        case .leading:
            if #available(iOS 11.0, *), item.isSafeArea {
                return item.view.safeAreaLayoutGuide.leadingAnchor
            }
            return item.view.leadingAnchor
        case .trailing:
            if #available(iOS 11.0, *), item.isSafeArea {
                return item.view.safeAreaLayoutGuide.trailingAnchor
            }
            return item.view.trailingAnchor
        default:
            fatalError("Use LayoutXAnchor only with: left, right, leading, trailing and centerX")
        }
    }

    func configure(layoutY item: LayoutConstraintItemConfigurable) -> LayoutYAnchor {
        switch item.attribute {
        case .top:
            if #available(iOS 11.0, *), item.isSafeArea {
                return item.view.safeAreaLayoutGuide.topAnchor
            }
            return item.view.topAnchor
        case .bottom:
            if #available(iOS 11.0, *), item.isSafeArea {
                return item.view.safeAreaLayoutGuide.bottomAnchor
            }
            return item.view.bottomAnchor
        case .centerY:
            if #available(iOS 11.0, *), item.isSafeArea {
                return item.view.safeAreaLayoutGuide.centerYAnchor
            }
            return item.view.centerYAnchor
        default:
            fatalError("Use LayoutYAnchor only with: top, bottom and centerY")
        }
    }

    func configure(dimension item: LayoutConstraintItemConfigurable) -> LayoutDimensionAnchor {
        switch item.attribute {
        case .height:
            if #available(iOS 11.0, *), item.isSafeArea {
                return item.view.safeAreaLayoutGuide.heightAnchor
            }
            return item.view.heightAnchor
        case .width:
            if #available(iOS 11.0, *), item.isSafeArea {
                return item.view.safeAreaLayoutGuide.widthAnchor
            }
            return item.view.widthAnchor
        default:
            fatalError("Use LayoutDimensionAnchor only with: height and width")
        }
    }

}

extension LayoutConstraintMakerExtendable: LayoutConstraintMakerRelatable {

    @discardableResult
    public func equalTo(_ item: LayoutConstraintItemable, constant: CGFloat = 0) -> LayoutConstraintMakerSupportable {
        let constantAnchor: LayoutConstraint = configureView(.equalTo, constant: constant, layout: item)
        constantAnchor.priority = LayoutPriortizable.required.priorityValue
        constantAnchor.isActive = true
        return LayoutConstraintMakerSupportable(constant: constantAnchor)
    }

    @discardableResult
    public func equalTo(constant: CGFloat) -> LayoutConstraintMakerSupportable {
        var constantAnchor: LayoutConstraint?
        switch attribute {
        case .width:
            constantAnchor = view.widthAnchor.constraint(equalToConstant: constant)
        case .height:
            constantAnchor = view.heightAnchor.constraint(equalToConstant: constant)
        default:
            fatalError("Layout attribute not implemented")
        }
        constantAnchor?.priority = LayoutPriortizable.required.priorityValue
        constantAnchor?.isActive = true
        return LayoutConstraintMakerSupportable(constant: constantAnchor)
    }

    @discardableResult
    public func greaterThanOrEqualTo(_ item: LayoutConstraintItemable, constant: CGFloat = 0) -> LayoutConstraintMakerSupportable {
        let constantAnchor: LayoutConstraint = configureView(.greaterThanOrEqualTo, constant: constant, layout: item)
        constantAnchor.priority = LayoutPriortizable.required.priorityValue
        constantAnchor.isActive = true
        return LayoutConstraintMakerSupportable(constant: constantAnchor)
    }

    @discardableResult
    public func greaterThanOrEqualTo(constant: CGFloat) -> LayoutConstraintMakerSupportable {
        var constantAnchor: LayoutConstraint?
        switch attribute {
        case .width:
            constantAnchor = view.widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
        case .height:
            constantAnchor = view.heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
        default:
            fatalError("Layout attribute not implemented")
        }
        constantAnchor?.isActive = true
        return LayoutConstraintMakerSupportable(constant: constantAnchor)
    }

    @discardableResult
    public func lessThanOrEqualTo(_ item: LayoutConstraintItemable, constant: CGFloat = 0) -> LayoutConstraintMakerSupportable {
        let constantAnchor: LayoutConstraint = configureView(.lessThanOrEqualTo, constant: constant, layout: item)
        constantAnchor.priority = LayoutPriortizable.required.priorityValue
        constantAnchor.isActive = true
        return LayoutConstraintMakerSupportable(constant: constantAnchor)
    }

    @discardableResult
    public func lessThanOrEqualTo(constant: CGFloat) -> LayoutConstraintMakerSupportable {
        var constantAnchor: LayoutConstraint?
        switch attribute {
        case .width:
            constantAnchor = view.widthAnchor.constraint(lessThanOrEqualToConstant: constant)
        case .height:
            constantAnchor = view.heightAnchor.constraint(lessThanOrEqualToConstant: constant)
        default:
            fatalError("Layout attribute not implemented")
        }
        constantAnchor?.isActive = true
        return LayoutConstraintMakerSupportable(constant: constantAnchor)
    }

}
