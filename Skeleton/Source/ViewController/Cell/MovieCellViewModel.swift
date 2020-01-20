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
    var posterImage: UIImageView { get }
    var voteAverage: Double { get }
    var didAction: (() -> Void)? { get }
}

struct MovieCellViewModel: MovieCellViewModelProtocol {

    var title: String
    var overview: String
    var releaseDate: String?
    var posterImage: UIImageView
    var voteAverage: Double
    var didAction: (() -> Void)?

    init() {
        self.title = String()
        self.overview = String()
        self.posterImage = UIImageView()
        self.voteAverage = 0.0
    }
    
    init(movie: Movie) {
        self.title = movie.title
        self.overview = movie.overview
        self.posterImage = UIImageView()
        self.voteAverage = movie.voteAverage
        self.releaseDate = MovieCellViewModel.formattedDateFromString(dateString: movie.releaseDate)
        
        if let path = movie.posterPath, let url = URL(string: "\(ConstantApi.baseImageURL)\(path)") {
            self.posterImage.load(url: url, placeholder: self.posterImage.image)
        }
    }
    
}

extension MovieCellViewModel {
        
    static func formattedDateFromString(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMMM dd, yyyy"
             return dateFormatter.string(from: date)
        }

        return nil
    }
    
}
