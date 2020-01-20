//
//  UIImageView+Cache.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 01/12/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request) { data, response, _ in
                DispatchQueue.main.async {
                    if let data = data,
                        let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                        let image = UIImage(data: data) {
                        
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        self.image = image
                        
                    } else {
                        self.image = UIImage(named: "no_image_holder")
                    }
                }
            }.resume()
        }
    }
}
