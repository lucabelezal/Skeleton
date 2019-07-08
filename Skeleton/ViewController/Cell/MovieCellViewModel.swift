//
//  MovieCellViewModel.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public protocol MovieCellViewModelProtocol {
    var path: String { get }
    var title: String { get }
    var overview: String { get }
    var didAction: (() -> Void)? { get }
    var isLoading: Bool { get }
}

public struct MovieCellViewModel: MovieCellViewModelProtocol {

    public var path: String
    public var title: String
    public var overview: String
    public var isLoading: Bool
    public var didAction: (() -> Void)?

    public init() {
        self.path = String()
        self.title = String()
        self.overview = String()
        self.isLoading = false
    }
}

public extension MovieCellViewModel {

    init(movie: Movie, isLoading: Bool) {
        self.path = "https://image.tmdb.org/t/p/w185/\(movie.posterPath)"
        self.title = movie.title
        self.overview = movie.overview
        self.isLoading = isLoading
    }
}
