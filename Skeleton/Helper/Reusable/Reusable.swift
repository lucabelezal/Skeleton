//
//  Reusable.swift
//  AudibleWalkthrough
//
//  Created by Lucas Nascimento on 07/10/18.
//  Copyright © 2018 Lucas Nascimento. All rights reserved.
//

import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public typealias NibReusable = Reusable & NibLoadable

public extension Reusable {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
