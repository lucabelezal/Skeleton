////
////  UIViewSkeleton.swift
////  SkeletonView
////
////  Created by Caio Ortu on 02/01/19.
////  Copyright © 2019 Caio Ortu. All rights reserved.
////
//
//import UIKit
//
//private enum AssociationPolicy: UInt {
//    case assign = 0
//    case copy = 771
//    case copyNonatomic = 3
//    case retain = 769
//    case retainNonatomic = 1
//
//    var objc: objc_AssociationPolicy {
//        return objc_AssociationPolicy(rawValue: rawValue)!
//    }
//}
//
//private enum AssociatedKeys {
//    static var skeletonable = "skeletonable"
//    static var status = "status"
//    static var skeletonLayer = "layer"
//    static var skeletonSize = "size"
//    static var centerSkeleton = "center"
//}
//
//extension UIView {
//
//    var isSkeletonActive: Bool {
//        return status == .on
//    }
//
//    @IBInspectable var isSkeletonable: Bool {
//        get { return skeletonable }
//        set { skeletonable = newValue }
//    }
//
//    @IBInspectable var skeletonSize: CGSize {
//        get { return skSize ?? frame.size }
//        set { skSize = CGSize(width: min(frame.width, newValue.width),
//                              height: min(frame.height, newValue.height)) }
//    }
//
//    @IBInspectable var shouldCenterSkeleton: Bool {
//        get { return objc_getAssociatedObject(self, &AssociatedKeys.centerSkeleton) as? Bool ?? false }
//        set { objc_setAssociatedObject(self, &AssociatedKeys.centerSkeleton, newValue, AssociationPolicy.retain.objc) }
//    }
//
//    func subviewsRecursive() -> [UIView] {
//        return subviews + subviews.flatMap { $0.subviewsRecursive() }
//    }
//}
//
//extension UIView {
//    enum Status {
//        case on
//        case off
//    }
//
//    fileprivate var skeletonable: Bool {
//        get { return objc_getAssociatedObject(self, &AssociatedKeys.skeletonable) as? Bool ?? false }
//        set { objc_setAssociatedObject(self, &AssociatedKeys.skeletonable, newValue, AssociationPolicy.retain.objc) }
//    }
//
//    fileprivate var skSize: CGSize? {
//        get { return objc_getAssociatedObject(self, &AssociatedKeys.skeletonSize) as? CGSize }
//        set { objc_setAssociatedObject(self, &AssociatedKeys.skeletonSize, newValue, AssociationPolicy.retain.objc) }
//    }
//
//    var skeletonLayer: CALayer? {
//        get { return objc_getAssociatedObject(self, &AssociatedKeys.skeletonLayer) as? CALayer }
//        set { objc_setAssociatedObject(self, &AssociatedKeys.skeletonLayer, newValue, AssociationPolicy.retain.objc) }
//    }
//
//    var status: Status {
//        get { return objc_getAssociatedObject(self, &AssociatedKeys.status) as? Status ?? .off }
//        set { objc_setAssociatedObject(self, &AssociatedKeys.status, newValue, AssociationPolicy.retain.objc) }
//    }
//}
//
//extension UIViewController {
//
//    func startAnimation() {
//        for animateView in getSubViewsForAnimate() {
//            animateView.showGradientSkeleton(usingGradient: SkeletonView.SkeletonGradient(baseColor: #colorLiteral(red: 0.831372549, green: 0.831372549, blue: 0.8705882353, alpha: 1)), animated: true)
//        }
//    }
//
//    func stopAnimation() {
//        for animateView in getSubViewsForAnimate() {
//            animateView.hideSkeleton()
//        }
//    }
//}
//
//extension UIViewController {
//
//    func getSubViewsForAnimate() -> [SkeletonView] {
//        var obj: [SkeletonView] = []
//        for objView in view.subviewsRecursive() {
//            if let skeletonView = objView as? SkeletonView {
//                 obj.append(skeletonView)
//            }
//        }
//        return obj.filter { (obj) -> Bool in
//            obj.isSkeletonable
//        }
//    }
//}
