//
//  UIView+Skeleton.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 10/12/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

struct AssociatedKeys {
    static var state: Int = 0
}

extension UIView {
    
    fileprivate var isSkeletonActive: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.state) as? Bool ?? false
        }
        set {
            return objc_setAssociatedObject(self, &AssociatedKeys.state, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @IBInspectable var isSkeletonable: Bool {
        get {
            return isSkeletonActive
        }
        set {
            self.isSkeletonActive = newValue
        }
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
    
}

extension UIView {
    
    public var maxBoundsEstimated: CGRect {
        if let parentStackView = (superview as? UIStackView) {
            var origin: CGPoint = .zero
            
            switch parentStackView.alignment {
            case .center:
                origin.x = maxWidthEstimated / 2
            case .trailing:
                origin.x = maxWidthEstimated
            default:
                break
            }
            
            return CGRect(origin: origin, size: maxSizeEstimated)
        }
        
        return CGRect(origin: .zero, size: maxSizeEstimated)
    }
    
    internal var maxSizeEstimated: CGSize {
        return CGSize(width: maxWidthEstimated, height: maxHeightEstimated)
    }
    
    internal var maxWidthEstimated: CGFloat {
        let constraintsWidth = nonContentSizeLayoutConstraints.filter { $0.firstAttribute == NSLayoutConstraint.Attribute.width }
        return max(between: frame.size.width, andContantsOf: constraintsWidth)
    }
    
    internal var maxHeightEstimated: CGFloat {
        let constraintsHeight = nonContentSizeLayoutConstraints.filter { $0.firstAttribute == NSLayoutConstraint.Attribute.height }
        return max(between: frame.size.height, andContantsOf: constraintsHeight)
    }
    
    private func max(between value: CGFloat, andContantsOf constraints: [NSLayoutConstraint]) -> CGFloat {
        let max = constraints.reduce(value, { max, constraint in
            var tempMax = max
            if constraint.constant > tempMax { tempMax = constraint.constant }
            return tempMax
        })
        return max
    }
    
    internal var nonContentSizeLayoutConstraints: [NSLayoutConstraint] {
        return constraints.filter { "\(type(of: $0))" != "NSContentSizeLayoutConstraint" }
    }
    
}
