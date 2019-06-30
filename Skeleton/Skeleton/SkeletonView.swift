//
//  SkeletonView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public class SkeletonView: UIView {

    var startLocations: [NSNumber]
    var endLocations: [NSNumber]
    var gradientBackgroundColor: CGColor
    var gradientMovingColor: CGColor
    var movingAnimationDuration: CFTimeInterval
    var delayBetweenAnimationLoops: CFTimeInterval
    var gradientLayer: CAGradientLayer

    public override init(frame: CGRect) {
        self.startLocations = [-1.0, -0.5, 0.0]
        self.endLocations = [1.0, 1.5, 2.0]
        self.gradientBackgroundColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        self.gradientMovingColor = UIColor(white: 0.75, alpha: 1.0).cgColor
        self.movingAnimationDuration = 0.8
        self.delayBetweenAnimationLoops = 1.0
        self.gradientLayer = CAGradientLayer()
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [
            gradientBackgroundColor,
            gradientMovingColor,
            gradientBackgroundColor,
        ]
        gradientLayer.locations = self.startLocations
        self.layer.addSublayer(gradientLayer)
        self.gradientLayer = gradientLayer
    }

    public func startAnimating() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = self.startLocations
        animation.toValue = self.endLocations
        animation.duration = self.movingAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = self.movingAnimationDuration + self.delayBetweenAnimationLoops
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        self.gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }

    public func stopAnimating() {
        self.gradientLayer.removeAllAnimations()
        self.gradientLayer.removeFromSuperlayer()
    }
}
