//
//  UIImageView+ Extension.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

//import UIKit

//let imageCache = NSCache<NSString, UIImage>()
//
//extension UIImageView {
//
//    func cacheImage(urlString: String) {
//
//        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
//            self.image = cachedImage
//            return
//        }
//
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with: url) { (data, _, error) in
//
//                if error != nil {
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    if let value = data, let downloadedImage = UIImage(data: value) {
//                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
//                        self.image = downloadedImage
//                    }
//                }
//            }.resume()
//        }
//    }
//}
