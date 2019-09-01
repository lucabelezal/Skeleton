//
//  MovieListViewModel.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

public protocol MovieListViewModelProtocol {
    var items: Int { get }
    var data: [MovieCellViewModelProtocol] { get }
}

public struct MovieListViewModel: MovieListViewModelProtocol {

    public var items: Int
    public var data: [MovieCellViewModelProtocol]

    public init() {
        self.items = 0
        self.data = []
    }
}

public extension MovieListViewModel {

    init(movies: [Movie]) {
        self.items = movies.count
        self.data = movies.map { MovieCellViewModel(movie: $0) }
    }
}
