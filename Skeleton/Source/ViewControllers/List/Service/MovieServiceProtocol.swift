//
//  MovieServiceProtocol.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 01/09/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Networking
import UIKit.UIImageView

protocol MovieServiceProtocol: class {
    func popularMovies(page: Int, isRequestCanceled: Bool, completion: @escaping (Result<PopularMovies>) -> Void)
    func loadImage(with path: String, completion: @escaping (UIImage) -> Void)
}
