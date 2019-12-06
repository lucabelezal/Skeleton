//
//  EnvironmentType.swift
//  Networking
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

public enum EnvironmentType {
    case qa
    case production
    case staging

    public var baseURL: String {
        switch self {
        case .production:
            return ConstantApi.productionUrl
        case .qa:
            return ConstantApi.qaUrl
        case .staging:
            return ConstantApi.stagingUrl
        }
    }
}