//
//  MovieCellViewModel.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Networking
import UIKit

protocol MovieCellViewModelProtocol {
    var title: String { get }
    var overview: String { get }
    var posterImage: UIImageView { get }
    var voteAverage: Double { get }
    var didAction: (() -> Void)? { get }
}

struct MovieCellViewModel: MovieCellViewModelProtocol {

    var title: String
    var overview: String
    var posterImage: UIImageView
    var voteAverage: Double
    var didAction: (() -> Void)?

    init(movie: Movie) {
        self.title = movie.title
        self.overview = movie.overview
        self.posterImage = UIImageView()
        self.voteAverage = movie.voteAverage

        if let path = movie.posterPath, let url = URL(string: "\(ConstantApi.baseImageURL)\(path)") {
            self.posterImage.load(url: url, placeholder: self.posterImage.image)
        }
    }
    
}
