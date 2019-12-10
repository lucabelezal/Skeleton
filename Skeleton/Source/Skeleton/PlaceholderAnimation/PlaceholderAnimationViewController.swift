//
//  PlaceholderAnimationViewController.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 06/12/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

struct AssociatedKeys {
    static var state: Int = 0
}

extension UIView {

    fileprivate var isAnimate: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.state) as? Bool ?? false
        }
        set {
            return objc_setAssociatedObject(self, &AssociatedKeys.state, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    @IBInspectable var isShimmerAnimation: Bool {
        get {
            return isAnimate
        }
        set {
            self.isAnimate = newValue
        }
    }

    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
}

extension UIViewController {

    func startLoading() {

        for animateView in getSubViewsForAnimate() {

            let colorLayer = CALayer()
            colorLayer.backgroundColor = UIColor(white: 0.82, alpha: 1).cgColor
            colorLayer.frame = animateView.maxBoundsEstimated
            colorLayer.name = "colorLayer"
            animateView.layer.addSublayer(colorLayer)
            animateView.autoresizesSubviews = true
            animateView.clipsToBounds = true

            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [
                UIColor(white: 0.82, alpha: 1).cgColor,
                UIColor(white: 0.86, alpha: 1).cgColor,
                UIColor(white: 0.82, alpha: 1).cgColor,
            ]
            gradientLayer.locations = [0, 0.4, 0.8, 1]
            gradientLayer.name = "gradientLayer"
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.frame = animateView.maxBoundsEstimated
            animateView.layer.addSublayer(gradientLayer)

            let pulseAnimation = CABasicAnimation(keyPath: "transform.translation.x")
            pulseAnimation.duration = 1.2
            pulseAnimation.fromValue = -animateView.frame.width
            pulseAnimation.toValue = animateView.frame.width
            pulseAnimation.repeatCount = .infinity
            gradientLayer.add(pulseAnimation, forKey: "smartLoader")
        }
    }

    func stopLoading() {
        for animateView in getSubViewsForAnimate() {
            if let smartLayers = animateView.layer.sublayers?.filter({ $0.name == "colorLayer" || $0.name == "gradientLayer" }) {
                smartLayers.forEach { $0.removeFromSuperlayer() }
            }
        }
    }
}

extension UIViewController {

    func getSubViewsForAnimate() -> [UIView] {
        var obj: [UIView] = []
        for objView in view.subviewsRecursive() {
            obj.append(objView)
        }
        return obj.filter { (obj) -> Bool in
            obj.isShimmerAnimation
        }
    }
}

extension UIView {
    
    var maxBoundsEstimated: CGRect {
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

    var maxSizeEstimated: CGSize {
        return CGSize(width: maxWidthEstimated, height: maxHeightEstimated)
    }

    var maxWidthEstimated: CGFloat {
        let constraintsWidth = nonContentSizeLayoutConstraints.filter { $0.firstAttribute == NSLayoutConstraint.Attribute.width }
        return max(between: frame.size.width, andContantsOf: constraintsWidth)
    }

    var maxHeightEstimated: CGFloat {
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

    var nonContentSizeLayoutConstraints: [NSLayoutConstraint] {
        return constraints.filter { "\(type(of: $0))" != "NSContentSizeLayoutConstraint" }
    }
    
}
