//
//  FAShimmerView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 31/08/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

class FAShimmerView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAndStartShimmering()
    }
}

class FAShimmerImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAndStartShimmering()
    }
}

class FAShimmerButtonView: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAndStartShimmering()
    }
}

class FAShimmerLabelView: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        configureAndStartShimmering()
    }
}

extension UIView {

    func configureAndStartShimmering() {

        backgroundColor = UIColor(red: 170 / 255, green: 170 / 255, blue: 170 / 255, alpha: 0.18)
        startShimmering()
    }
}

extension UIView {

    func startShimmering() {

        let light = UIColor(white: 0, alpha: 0.1).cgColor
        let dark = UIColor.black.cgColor

        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [dark, light, dark]
        gradient.frame = CGRect(x: -bounds.size.width, y: 0, width: 3 * bounds.size.width, height: bounds.size.height)

        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations  = [0.4, 0.5, 0.6]

        layer.mask = gradient

        let animation: CABasicAnimation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue   = [0.8, 0.9, 1.0]

        animation.duration = 1.5
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.isRemovedOnCompletion = false

        gradient.add(animation, forKey: "shimmer")
    }

    func stopShimmering() {

        layer.mask = nil
    }
}

class FAView: UIView {

    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }

        set {
            layer.cornerRadius = newValue
        }
    }

    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }

        set {
            layer.borderWidth = newValue
        }
    }

    public var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }

        set {
            layer.borderColor = newValue.cgColor
        }
    }

    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
