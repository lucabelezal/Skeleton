//
//  NetworkEnvironment.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

public enum Environment {
    case qa
    case production
    case staging

    public static var baseURL: String {
        switch NetworkManager.environment {
        case .production:
            return "https://api.themoviedb.org/3/movie/"
        case .qa:
            return "https://qa.themoviedb.org/3/movie/"
        case .staging:
            return "https://staging.themoviedb.org/3/movie/"
        }
    }
}
