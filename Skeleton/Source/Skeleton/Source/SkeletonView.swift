////
////  SkeletonView.swift
////  SkeletonView
////
////  Created by Caio Ortu on 02/01/19.
////  Copyright © 2019 Caio Ortu. All rights reserved.
////
//
//import UIKit
//
//class SkeletonView: UIView {
//
//    fileprivate var skeletonColor: UIColor?
//    fileprivate var skeletonGradient: SkeletonGradient?
//    fileprivate var skeletonType: SkeletonType?
//    fileprivate(set) var isAnimated: Bool = false
//
//    func showSkeleton(usingColor color: UIColor = #colorLiteral(red: 0.9254901961, green: 0.9411764706, blue: 0.9450980392, alpha: 1), animated: Bool = false) {
//        skeletonColor = color
//        if isSkeletonActive {
//            resetSkeleton()
//        } else {
//            showSkeleton(withType: .solid, usingColors: [color], animated: animated)
//        }
//    }
//
//    func showGradientSkeleton(usingGradient gradient: SkeletonGradient = SkeletonGradient(baseColor: #colorLiteral(red: 0.9254901961, green: 0.9411764706, blue: 0.9450980392, alpha: 1)), animated: Bool = false) {
//        skeletonGradient = gradient
//        if isSkeletonActive {
//            resetSkeleton()
//        } else {
//            showSkeleton(withType: .gradient, usingColors: gradient.colors, animated: animated)
//        }
//    }
//
//    func setSkeletonColor(_ color: UIColor?, orGradient gradient: SkeletonGradient?) {
//        skeletonColor = color
//        skeletonGradient = gradient
//    }
//
//    fileprivate func showSkeleton(withType type: SkeletonType, usingColors colors: [UIColor], animated: Bool) {
//        skeletonType = type
//        isAnimated = animated
//        addAppNotificationsObservers()
//        status = .on
//        buildSkeleton(for: subviews, usingColors: colors)
//    }
//
//    fileprivate func buildSkeleton(for views: [UIView], usingColors colors: [UIColor]) {
//        guard let skeletonType = skeletonType else { return }
//        views.forEach { (view) in
//            let newColors = view.getSkeletonColors(or: colors, withType: skeletonType)
//            if view.isSkeletonable && !view.isSkeletonActive {
//                buildSkeleton(for: view, usingColors: newColors)
//            } else if let stackView = view as? UIStackView, !stackView.arrangedSubviews.isEmpty {
//                buildSkeleton(for: stackView.arrangedSubviews, usingColors: newColors)
//            } else if !view.subviews.isEmpty {
//                buildSkeleton(for: view.subviews, usingColors: newColors)
//            }
//        }
//    }
//
//    fileprivate func buildSkeleton(for view: UIView, usingColors colors: [UIColor]) {
//        guard let skeletonType = skeletonType else { return }
//        let maskLayer = CAShapeLayer()
//        let midPoint = CGPoint(x: (view.frame.width / 2) - (view.skeletonSize.width / 2),
//                               y: (view.frame.height / 2) - (view.skeletonSize.height / 2))
//        maskLayer.path = CGPath(roundedRect: CGRect(origin: view.shouldCenterSkeleton ? midPoint : .zero,
//                                                    size: view.skeletonSize), cornerWidth: 0, cornerHeight: 0, transform: nil)
//        view.layer.mask = maskLayer
//        view.addSkeletonLayer(withType: skeletonType, usingColors: colors, animated: isAnimated)
//        view.status = .on
//    }
//
//    func restartSkeleton() {
//        if isSkeletonActive { resetSkeleton() }
//    }
//
//    fileprivate func resetSkeleton() {
//        guard let skeletonType = skeletonType else { return }
//        hideSkeleton()
//        if case .solid = skeletonType, let skeletonColor = skeletonColor {
//            showSkeleton(usingColor: skeletonColor, animated: isAnimated)
//        } else if case .gradient = skeletonType, let skeletonGradient = skeletonGradient {
//            showGradientSkeleton(usingGradient: skeletonGradient, animated: isAnimated)
//        }
//    }
//
//    func hideSkeleton() {
//        removeAppNoticationsObserver()
//        removeSkeleton(of: subviews)
//    }
//
//    fileprivate func removeSkeleton(of views: [UIView]) {
//        status = .off
//        views.forEach { (view) in
//            if view.isSkeletonable {
//                view.removeSkeletonLayer()
//                view.status = .off
//            } else if let stackView = view as? UIStackView, !stackView.arrangedSubviews.isEmpty {
//                removeSkeleton(of: stackView.arrangedSubviews)
//            } else if !view.subviews.isEmpty {
//                removeSkeleton(of: view.subviews)
//            }
//        }
//    }
//}
//
//extension SkeletonView {
//    typealias SkeletonLayerAnimation = (CALayer) -> CAAnimation
//
//    enum SkeletonType {
//        case solid
//        case gradient
//
//        var layer: CALayer {
//            switch self {
//            case .solid:
//                return CALayer()
//            case .gradient:
//                return CAGradientLayer()
//            }
//        }
//
//        var layerAnimation: SkeletonLayerAnimation {
//            switch self {
//            case .solid:
//                return { $0.pulse }
//            case .gradient:
//                return { $0.sliding }
//            }
//        }
//    }
//
//    struct SkeletonGradient {
//        private var gradientColors: [UIColor]
//
//        var colors: [UIColor] {
//            return gradientColors
//        }
//
//        init(baseColor: UIColor, secondaryColor: UIColor? = nil) {
//            if let secondary = secondaryColor {
//                self.gradientColors = [baseColor, secondary, baseColor]
//            } else {
//                self.gradientColors = baseColor.makeGradient()
//            }
//        }
//    }
//}
//
//fileprivate extension UIView {
//    func addSkeletonLayer(withType type: SkeletonView.SkeletonType, usingColors colors: [UIColor], animated: Bool) {
//        skeletonLayer?.removeFromSuperlayer()
//        skeletonLayer = type.layer
//        skeletonLayer?.frame = bounds
//        skeletonLayer?.tint(withColors: colors)
//        layer.addSublayer(skeletonLayer!)
//        if animated { skeletonLayer?.startAnimation(for: type) }
//    }
//
//    func removeSkeletonLayer() {
//        skeletonLayer?.removeAllAnimations()
//        skeletonLayer?.removeFromSuperlayer()
//        layer.mask = nil
//    }
//
//    func getSkeletonColors(or colors: [UIColor], withType type: SkeletonView.SkeletonType) -> [UIColor] {
//        let newColors: [UIColor]
//        switch type {
//        case .gradient:
//            if let skView = self as? SkeletonView, let gradient = skView.skeletonGradient {
//                newColors = gradient.colors
//            } else {
//                newColors = colors
//            }
//        case .solid:
//            if let skView = self as? SkeletonView, let color = skView.skeletonColor {
//                newColors = [color]
//            } else {
//                newColors = colors
//            }
//        }
//        return newColors
//    }
//}
