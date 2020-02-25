//
//  MovieListViewModel.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Networking

protocol MovieListViewModelProtocol {
    var isToReloadTableView: Bool { get }
    var totalCount: Int { get }
    var currentCount: Int { get }
    var movie: (_ index: Int) -> MovieCellViewModelProtocol { get }
    var indexPathsToReload: [IndexPath]? { get }
}

struct MovieListViewModel: MovieListViewModelProtocol {

    var isToReloadTableView: Bool
    var totalCount: Int
    var currentCount: Int
    var movie: (Int) -> MovieCellViewModelProtocol
    var indexPathsToReload: [IndexPath]?
    
    init() {
        self.isToReloadTableView = false
        self.totalCount = 5
        self.currentCount = 5
        self.movie = { _ in return MovieCellViewModel() }
    }
    
    init(with data: PopularMovies, and movies: [Movie], isToReloadTableView: Bool) {
        self.isToReloadTableView = isToReloadTableView
        self.totalCount = data.totalResults
        self.currentCount = movies.count
        self.movie = { index in
            return MovieCellViewModel(movie: movies[index])
        }
        
        if data.page > 1 {
            indexPathsToReload = MovieListViewModel.calculateIndexPathsToReload(from: data.movies, with: movies)
        }
    }
    
    private static func calculateIndexPathsToReload(from newMovies: [Movie], with allMovies: [Movie]) -> [IndexPath] {
        let startIndex = allMovies.count - newMovies.count
        let endIndex = startIndex + newMovies.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
