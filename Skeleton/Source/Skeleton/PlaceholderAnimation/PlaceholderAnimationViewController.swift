////
////  PlaceholderAnimationViewController.swift
////  Skeleton
////
////  Created by Lucas Nascimento on 06/12/19.
////  Copyright © 2019 Lucas Nascimento. All rights reserved.
////
//
//import UIKit
//
////PlaceholderAnimation
//
//var associateObjectValuePlaceholderAnimation: Int = 0 // swiftlint:disable:this identifier_name
//
//extension UIView {
//
//    fileprivate var isAnimate: Bool {
//        get {
//            return objc_getAssociatedObject(self, &associateObjectValuePlaceholderAnimation) as? Bool ?? false
//        }
//        set {
//            return objc_setAssociatedObject(self, &associateObjectValuePlaceholderAnimation, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//
//    @IBInspectable var shimmerAnimationPlaceholderAnimation: Bool { // swiftlint:disable:this identifier_name
//        get {
//            return isAnimate
//        }
//        set {
//            self.isAnimate = newValue
//        }
//    }
//
//    func subviewsRecursivePlaceholderAnimation() -> [UIView] {
//        return subviews + subviews.flatMap { $0.subviewsRecursivePlaceholderAnimation() }
//    }
//}
//
//extension UIViewController {
//
//    func startPlaceholderAnimation() {
//        
//        for animateView in getSubViewsForPlaceholderAnimate() {
//            
//            let colorLayer = CALayer()
//            colorLayer.backgroundColor = UIColor(white: 0.82, alpha: 1).cgColor
//            colorLayer.frame = animateView.bounds
//            colorLayer.name = "colorLayer"
//            animateView.layer.addSublayer(colorLayer)
//            animateView.autoresizesSubviews = true
//            animateView.clipsToBounds = true
//
//            let gradientLayer = CAGradientLayer()
//            gradientLayer.colors = [
//                UIColor(white: 0.82, alpha: 1).cgColor,
//                UIColor(white: 0.86, alpha: 1).cgColor,
//                UIColor(white: 0.82, alpha: 1).cgColor,
//            ]
//            gradientLayer.locations = [0, 0.4, 0.8, 1]
//            gradientLayer.name = "loaderLayer"
//            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//            gradientLayer.frame = animateView.bounds
//            animateView.layer.addSublayer(gradientLayer)
//           
//            let animation = CABasicAnimation(keyPath: "transform.translation.x")
//            animation.duration = 1.2
//            animation.fromValue = -animateView.frame.width
//            animation.toValue = animateView.frame.width
//            animation.repeatCount = .infinity
//            gradientLayer.add(animation, forKey: "smartLoader")
//        }
//    }
//
//    func stopPlaceholderAnimation() {
//        for animateView in getSubViewsForPlaceholderAnimate() {
//            //animateView.layer.removeAllAnimations()
//            //animateView.layer.mask = nil
//            
//            if let smartLayers = animateView.layer.sublayers?.filter({ $0.name == "colorLayer" || $0.name == "loaderLayer" }) {
//                smartLayers.forEach({ $0.removeFromSuperlayer() })
//            }
//            
//        }
//    }
//}
//
//extension UIViewController {
//
//    func getSubViewsForPlaceholderAnimate() -> [UIView] {
//        var obj: [UIView] = []
//        for objView in view.subviewsRecursivePlaceholderAnimation() {
//            obj.append(objView)
//        }
//        return obj.filter({ (obj) -> Bool in
//            obj.shimmerAnimationPlaceholderAnimation
//        })
//    }
//}
