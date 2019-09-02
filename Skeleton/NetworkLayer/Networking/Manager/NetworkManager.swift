//
//  NetworkManager.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/11.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public protocol NetworkManagerProtocol {
    var environment: EnvironmentType { get }
    static var baseURL: String? { get set }
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>
}

public struct NetworkManager: NetworkManagerProtocol {

    public var environment: EnvironmentType
    public static var baseURL: String?

    init(environment: EnvironmentType) {
        self.environment = environment
        NetworkManager.baseURL = environment.baseURL
    }

    public func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success(NetworkResponse.success.description)
        case 401...500: return .failure(NetworkResponse.authenticationError)
        case 501...599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
}
