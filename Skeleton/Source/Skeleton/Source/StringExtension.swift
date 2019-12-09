////
////  StringExtension.swift
////  SkeletonView
////
////  Created by Caio Ortu on 02/01/19.
////  Copyright © 2019 Caio Ortu. All rights reserved.
////
//
//import UIKit
//
//extension String {
//    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
//        return boundingBox.height
//    }
//
//    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
//
//        return boundingBox.width
//    }
//}
