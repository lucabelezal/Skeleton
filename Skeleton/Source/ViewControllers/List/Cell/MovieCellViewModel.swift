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
    var releaseDate: String? { get }
    var posterImage: UIImageView? { get }
    var voteAverage: Double { get }
    var didAction: (() -> Void)? { get }
}

struct MovieCellViewModel: MovieCellViewModelProtocol {
    
    var title: String
    var overview: String
    var releaseDate: String?
    var posterImage: UIImageView?
    var voteAverage: Double
    var didAction: (() -> Void)?
    
    init() {
        self.title = "No Title"
        self.overview = "We don't have a synopsis"
        self.posterImage = UIImageView(image: UIImage(named: "no_image_holder"))
        self.voteAverage = 0.0
    }
}

extension MovieCellViewModel {

    init(movie: Movie) {
        self.title = movie.title
        self.overview = movie.overview.isEmpty ? "We don't have a synopsis" : movie.overview
        self.voteAverage = movie.voteAverage
        self.releaseDate = movie.releaseDate.formattedDateFromString()
        self.posterImage = UIImageView(image: UIImage(named: "no_image_holder"))

        if let path = movie.posterPath, let url = "\(ConstantApi.baseImageURL)\(path)".toURL {
            self.posterImage?.loadImage(with: url)
        }
    }
}
