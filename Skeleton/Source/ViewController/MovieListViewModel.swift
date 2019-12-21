//
//  MovieListViewModel.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Networking

protocol MovieListViewModelProtocol {
    var nextPage: Int { get }
    var items: Int { get }
    var data: [MovieCellViewModelProtocol] { get }
}

struct MovieListViewModel: MovieListViewModelProtocol {

    var nextPage: Int
    var items: Int
    var data: [MovieCellViewModelProtocol]

    init(movies: [Movie], page: Int, totalPages: Int) {
        self.nextPage = page <= totalPages ? page + 1 : 1
        self.items = movies.count
        self.data = movies.map { MovieCellViewModel(movie: $0) }
    }
    
}
