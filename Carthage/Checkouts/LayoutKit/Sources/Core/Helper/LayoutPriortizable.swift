//
//  LayoutPriortizable.swift
//  LayoutKit
//
//  Created by Vinicius França on 30/09/18.
//  Copyright © 2018 Vinicius França. All rights reserved.
//

import UIKit

public enum LayoutPriortizable {
    case low
    case medium
    case high
    case required
    case value(Float)
}

extension LayoutPriortizable {

    internal var priorityValue: UILayoutPriority {

        var priorityValue: Float = 0.0
        switch self {
        case .low:
            priorityValue = 250.0
        case .medium:
            priorityValue = 500.0
        case .high:
            priorityValue = 750.0
        case .required:
            priorityValue = 999.0
        case .value(let priority):
            priorityValue = priority
        }
        return UILayoutPriority(rawValue: priorityValue)
    }
}
