//
//  MovieService.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 01/09/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Networking

class MovieService: MovieServiceProtocol {

    var networkManager: NetworkManagerProtocol
    var router: Router<MovieRouter>

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.router = Router<MovieRouter>()
    }

    func popularMovies(page: Int, flag: Bool, completion: @escaping (Result<PopularMovies>) -> Void) {
        if flag == false {
            return router.cancel()
        }

        router.request(.newMovies(page: page)) { data, response, error in

            if error != nil {
                completion(.failure(NetworkResponse.connection))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.networkManager.handleNetworkResponse(response)
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
    
}
