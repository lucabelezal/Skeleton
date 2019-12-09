//
//  CALayerSkeleton.swift
//  SkeletonView
//
//  Created by Caio Ortu on 08/01/19.
//  Copyright © 2019 Caio Ortu. All rights reserved.
//

import UIKit

extension CALayer {
    @objc func tint(withColors colors: [UIColor]) {
        backgroundColor = colors.first?.cgColor
    }
}

extension CAGradientLayer {
    override func tint(withColors colors: [UIColor]) {
        self.colors = colors.map { $0.cgColor }
    }
}

extension CALayer {
    var pulse: CAAnimation {
        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.backgroundColor))
        pulseAnimation.fromValue = frame.size.height
        pulseAnimation.toValue = -frame.size.height
        pulseAnimation.duration = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        return pulseAnimation
    }

    var sliding: CAAnimation {
        let startPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.startPoint))
        startPointAnim.fromValue = CGPoint(x: -1, y: 0.5)
        startPointAnim.toValue = CGPoint(x: 1, y: 0.5)

        let endPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.endPoint))
        endPointAnim.fromValue = CGPoint(x: 0, y: 0.5)
        endPointAnim.toValue = CGPoint(x: 2, y: 0.5)

        let animGroup = CAAnimationGroup()
        animGroup.animations = [startPointAnim, endPointAnim]
        animGroup.duration = 1.5
        animGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animGroup.repeatCount = .infinity

        return animGroup
    }

    func startAnimation(for type: SkeletonView.SkeletonType) {
        let animation = type.layerAnimation
        playAnimation(animation, key: "skeletonAnimation")
    }

    func playAnimation(_ anim: SkeletonView.SkeletonLayerAnimation, key: String) {
        add(anim(self), forKey: key)
    }

    func stopAnimation(forKey key: String) {
        removeAnimation(forKey: key)
    }
}
