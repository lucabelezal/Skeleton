//
//  MovieCellViewModel.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Kingfisher
import UIKit

public protocol MovieCellViewModelProtocol {
    var title: String { get }
    var overview: String { get }
    var posterImage: ImageView { get }
    var didAction: (() -> Void)? { get }
}

public struct MovieCellViewModel: MovieCellViewModelProtocol {

    public var title: String
    public var overview: String
    public var posterImage: ImageView
    public var didAction: (() -> Void)?

    public init() {
        self.title = String()
        self.overview = String()
        self.posterImage = ImageView()
    }
}

public extension MovieCellViewModel {

    init(movie: Movie) {
        self.init()
        self.title = movie.title
        self.overview = movie.overview
        if let path = movie.posterPath {
            if let url = URL(string: "https://image.tmdb.org/t/p/w185\(path)") {
                self.posterImage.kf.setImage(with: url)
            }
        }
    }
}
