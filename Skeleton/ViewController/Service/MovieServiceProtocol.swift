//
//  MovieServiceProtocol.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 01/09/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

public protocol MovieServiceProtocol: class {
    func getNewMovies(page: Int, flag: Bool, completion: @escaping (Result<PopularMovies>) -> Void)
}
