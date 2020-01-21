//
//  UIImageView+Cache.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 01/12/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(with url: URL, into placeholder: UIImage?, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request) { data, response, _ in
                if let data = data,
                    let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                    let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        self.image = image
                    }
                
                }
                
            }.resume()
        }
    }
}
