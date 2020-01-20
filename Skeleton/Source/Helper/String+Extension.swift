//
//  String+Extension.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 20/01/20.
//  Copyright © 2020 Lucas Nascimento. All rights reserved.
//

import Foundation

public extension String {
    var toURL: URL? {
        return URL(string: self)
    }
}
