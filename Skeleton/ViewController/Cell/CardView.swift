//
//  CardView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 09/07/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public class CardView: UIView {

    var cornerRadius: CGFloat = 2

    var shadowOffsetWidth: Int = 0
    var shadowOffsetHeight: Int = 3
    var shadowColor: UIColor? = .black
    var shadowOpacity: Float = 0.5

    override public func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}
