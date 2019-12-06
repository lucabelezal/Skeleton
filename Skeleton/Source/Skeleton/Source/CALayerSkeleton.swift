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
        pulseAnimation.fromValue = backgroundColor
        pulseAnimation.toValue = UIColor(cgColor: backgroundColor!).complementaryColor.cgColor
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
    
    /// Start to play the skeleton animation closure for the specified skeleton type.
    ///
    /// - Parameter type: The skeleton type used to decide the animation.
    func startAnimation(for type: SkeletonView.SkeletonType) {
        let animation = type.layerAnimation
        playAnimation(animation, key: "skeletonAnimation")
    }
    
    /// Play the specified skeleton animation closure to the layer.
    ///
    /// - Parameters:
    ///   - anim: The animation to be added and played in the render tree. This object is copied by the render tree, not referenced. Therefore, subsequent modifications to the object are not propagated into the render tree.
    ///   - key: A string that identifies the animation. Only one animation per unique key is added to the layer. The special key kCATransition is automatically used for transition animations. You may specify nil for this parameter.
    func playAnimation(_ anim: SkeletonView.SkeletonLayerAnimation, key: String) {
        add(anim(self), forKey: key)
    }
    
    /// Stop the animation with the specified key.
    ///
    /// - Parameter key: The identifier of the animation to stop.
    func stopAnimation(forKey key: String) {
        removeAnimation(forKey: key)
    }
}
