//
//  NetworkManager.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

//CRIAR UM SERVICE QUE IMPLEMENT E CHAME service.router....
public struct NetworkManager {

    static let environment: Environment = .production
    static let MovieAPIKey = Key.apiKey

    let router = Router<MovieRouter>()

    func getNewMovies(page: Int, flag: Bool, completion: @escaping (Result<PopularMovies>) -> Void) {

        if flag == false {
            return router.cancel()
        }

        router.request(.newMovies(page: page)) { data, response, error in

            if error != nil {
                completion(.failure(NetworkResponse.connection))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NetworkResponse.noData))
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(PopularMovies.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        print(error)
                        completion(.failure(NetworkResponse.unableToDecode))
                    }
                case .failure(let networkFailureError):
                    completion(.failure(networkFailureError))
                }
            }
        }
    }

    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success(NetworkResponse.success.description)
        case 401...500: return .failure(NetworkResponse.authenticationError)
        case 501...599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
}