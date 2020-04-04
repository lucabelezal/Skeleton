//
//  NetworkResponse.swift
//  Networking
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

public enum NetworkResponse: Error {
    case success
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
    case connection

    public var description: String {
        switch self {
        case .success:
            return String()
        case .authenticationError:
            return "You need to be authenticated first."
        case .badRequest:
            return "Bad request"
        case .outdated:
            return "The url you requested is outdated."
        case .failed:
            return "Network request failed."
        case .noData:
            return "Response returned with no data to decode."
        case .unableToDecode:
            return "We could not decode the response."
        case .connection:
            return "Please check your network connection."
        }
    }
}
