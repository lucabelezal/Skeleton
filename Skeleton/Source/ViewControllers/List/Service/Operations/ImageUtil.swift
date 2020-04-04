//
//  ImageUtil.swift
//  Skeleton
//
//  Created by l.b.do.nascimento on 31/03/20.
//  Copyright © 2020 Lucas Nascimento. All rights reserved.
//

import UIKit

typealias ImageCompletionHandler = (ImageResult) -> Void

protocol ImageCache {
    func downloadImage(at url: URL, indexPath: IndexPath, completion: @escaping ImageCompletionHandler)
}

class ImageUtil: ImageCache {

    private var taskQueue: TaskQueue
    static let shared = ImageUtil()
    private lazy var imageCache = NSCache<NSString, UIImage>()

    init(queue: TaskQueue = FlickrTaskQueue.shared) {
        self.taskQueue = queue
    }

    func downloadImage(at url: URL, indexPath: IndexPath, completion: @escaping ImageCompletionHandler) {
        self.taskQueue.execute {
            if let cachedImage = self.imageCache.object(forKey: url.absoluteString as NSString) {

                completion(ImageResult.success(image: cachedImage, imageUrl: url, indexPath: indexPath))

            } else {

                var imageTask = self.taskQueue.task(for: url.absoluteString) as? ImageTask

                if imageTask == nil {

                    imageTask = ImageTask(url: url, indexPath: indexPath)

                    imageTask?.completionBlock = {
                        guard let result = imageTask?.result else { return }
                        switch result {
                        case ImageResult.success(let image, let url, _):
                            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        case ImageResult.error(let error, _):
                            print("\(String(describing: error))")
                        }
                        completion(result)
                    }

                    if let task = imageTask, case .high = task.queuePriority {
                        self.taskQueue.add(task)
                    }

                } else {
                    imageTask?.queuePriority = .veryHigh
                }
            }
        }
    }
}
