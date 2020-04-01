//
//  DataTask.swift
//  Skeleton
//
//  Created by l.b.do.nascimento on 31/03/20.
//  Copyright © 2020 Lucas Nascimento. All rights reserved.
//

import UIKit

final class DataTask<T: Decodable>: AsyncTask {

    private (set) var url: URL
    var result: T?
    required init(_ page: Int, url: URL) {
        self.url = url
        super.init("\(page)")
    }

    override func execute() {

        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let photos = try? JSONDecoder().decode(T.self, from: data) else {
                self.finish(true)
                return
            }
            self.result = photos
            self.finish(true)
        }
        dataTask.resume()
    }
}
