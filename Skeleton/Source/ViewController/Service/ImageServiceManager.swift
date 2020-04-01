//
//  ImageServiceManager.swift
//  Skeleton
//
//  Created by l.b.do.nascimento on 31/03/20.
//  Copyright © 2020 Lucas Nascimento. All rights reserved.
//

import Foundation
import struct Networking.Movie
import class Networking.ConstantApi

protocol ImageServiceManagerProtocol {
    func fetchImageFor(_ movie: Movie, _ indexPath: IndexPath, completion: @escaping ImageCompletionHandler)
}

class ImageServiceManager: ImageServiceManagerProtocol {

    private var queue: TaskQueue
    static let shared = ImageServiceManager()

    init(_ taskQueue: TaskQueue = FlickrTaskQueue.shared) {
        self.queue = taskQueue
    }

    func fetchImageFor(_ movie: Movie, _ indexPath: IndexPath, completion: @escaping ImageCompletionHandler) {

        guard let path = movie.posterPath, let url = URL(string: "\(ConstantApi.baseImageURL)\(path)") else {
            return
        }

        ImageUtil.shared.downloadImage(at: url, indexPath: indexPath, completion: completion)
    }

}
