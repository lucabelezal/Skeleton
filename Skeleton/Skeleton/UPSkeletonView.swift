////
////  UPSkeletonView.swift
////  Skeleton
////
////  Created by Lucas Nascimento on 10/07/19.
////  Copyright © 2019 Lucas Nascimento. All rights reserved.
////
//
//import UIKit
//
//public class UPSkeletonView: UIView {
//
//    var startLocations: [NSNumber] = [-1.0, -0.5, 0.0]
//    var endLocations: [NSNumber] = [1.0, 1.5, 2.0]
//    var gradientBackgroundColor: CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
//    var gradientMovingColor: CGColor = UIColor(white: 0.75, alpha: 1.0).cgColor
//    var movingAnimationDuration: CFTimeInterval = 0.8
//    var delayBetweenAnimationLoops: CFTimeInterval = 1.0
//    var gradientLayer: CAGradientLayer = CAGradientLayer()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//        gradientLayer.colors = [
//            gradientBackgroundColor,
//            gradientMovingColor,
//            gradientBackgroundColor,
//        ]
//        gradientLayer.locations = self.startLocations
//        self.layer.addSublayer(gradientLayer)
//        self.gradientLayer = gradientLayer
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override public func layoutSubviews() {
//        super.layoutSubviews()
//        gradientLayer.frame = self.bounds
//    }
//
//    public func startAnimating() {
//        let animation = CABasicAnimation(keyPath: "locations")
//        animation.fromValue = self.startLocations
//        animation.toValue = self.endLocations
//        animation.duration = self.movingAnimationDuration
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//
//        let animationGroup = CAAnimationGroup()
//        animationGroup.duration = self.movingAnimationDuration + self.delayBetweenAnimationLoops
//        animationGroup.animations = [animation]
//        animationGroup.repeatCount = .infinity
//        self.gradientLayer.add(animationGroup, forKey: animation.keyPath)
//    }
//
//    public func stopAnimating() {
//        self.gradientLayer.removeAllAnimations()
//        self.gradientLayer.removeFromSuperlayer()
//    }
//}
