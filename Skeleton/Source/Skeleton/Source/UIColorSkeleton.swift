////
////  UIColorSkeleton.swift
////  SkeletonView
////
////  Created by Caio Ortu on 08/01/19.
////  Copyright © 2019 Caio Ortu. All rights reserved.
////
//
//import UIKit
//
//extension UIColor {
//    func isLight() -> Bool {
//        guard let components = cgColor.components,
//            components.count >= 3 else { return false }
//        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
//        return !(brightness < 0.5)
//    }
//
//    var complementaryColor: UIColor {
//        return isLight() ? darker : lighter
//    }
//
//    var lighter: UIColor {
//        return adjust(by: 1.35)
//    }
//
//    var darker: UIColor {
//        return adjust(by: 0.94)
//    }
//
//    func adjust(by percent: CGFloat) -> UIColor {
//        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
//        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
//        return UIColor(hue: hue, saturation: saturation, brightness: brightness * percent, alpha: alpha)
//    }
//
//    func makeGradient() -> [UIColor] {
//        return [self, self.complementaryColor, self]
//    }
//}
