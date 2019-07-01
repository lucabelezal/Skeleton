//
//  UIView+ Extension.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public extension UIView {

    func setMaskingViews(_ views: [UIView]) { //_ views: UIView...
        let mutablePath = CGMutablePath()

        views.forEach { view in

            guard self.subviews.contains(view) else {
                fatalError("View:\(view) is not a subView of \(self). Therefore, it cannot be a masking view.")
            }

            if view.layer.cornerRadius == view.frame.size.height / 2, view.layer.masksToBounds {
                mutablePath.addEllipse(in: view.frame)
            } else {
                mutablePath.addRect(view.frame)
            }
        }

        let maskLayer = CAShapeLayer()
        maskLayer.path = mutablePath

        self.layer.mask = maskLayer
    }
}
