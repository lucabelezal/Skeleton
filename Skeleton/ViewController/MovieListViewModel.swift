//
//  MovieListViewModel.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

public protocol MovieListViewModelProtocol {
    var data: [MovieCellViewModelProtocol] { get }
}

public struct MovieListViewModel: MovieListViewModelProtocol {

    public var data: [MovieCellViewModelProtocol]

    public init() {
        self.data = []
    }
}

public extension MovieListViewModel {

    init(movies: [Movie], isLoading: Bool) {
        self.data = movies.map { MovieCellViewModel(movie: $0, isLoading: isLoading) }
    }
}
