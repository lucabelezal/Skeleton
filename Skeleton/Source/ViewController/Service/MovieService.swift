//
//  MovieService.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 01/09/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Networking
import UIKit

class MovieService: MovieServiceProtocol {
    
    var networkManager: NetworkManagerProtocol
    var router: Router<MovieRouter>
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.router = Router<MovieRouter>()
    }
    
    func popularMovies(page: Int, isRequestCanceled: Bool, completion: @escaping (Result<PopularMovies>) -> Void) {
        
        if isRequestCanceled {
            router.cancelRequest()
            return
        }

        DispatchQueue.global(qos: .background).async {
            self.router.request(.newMovies(page: page)) { data, response, error in

                if error != nil {
                    completion(.failure(NetworkResponse.connection))
                }

                if let response = response as? HTTPURLResponse {
                    let result = self.networkManager.handleNetworkResponse(response)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        switch result {
                        case .success:
                            guard let responseData = data else {
                                completion(.failure(NetworkResponse.noData))
                                return
                            }
                            do {
                                let apiResponse = try JSONDecoder().decode(PopularMovies.self, from: responseData)
                                completion(.success(apiResponse))
                            } catch {
                                completion(.failure(NetworkResponse.unableToDecode))
                            }
                        case .failure(let networkFailureError):
                            completion(.failure(networkFailureError))
                        }
                    }
                }
            }
        }

    }
    
    func loadImage(with path: String, completion: @escaping (UIImage) -> Void) {
        
        guard let url = URL(string: "\(ConstantApi.baseImageURL)\(path)") else {
            return completion(UIImage())
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, _ in
            if let data = data,
                let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
                
            } else {
                completion(UIImage())
            }
        }.resume()
        
    }
    
}
