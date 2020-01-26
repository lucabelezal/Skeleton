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
    var posterPath: String? { get }
    var didAction: (() -> Void)? { get set }
    
    var loadImage: ((String) -> UIImage)? { get }
    var backComplition: ((UIImage) -> Void)? { get set }
}

struct MovieCellViewModel: MovieCellViewModelProtocol {
    
    var title: String
    var overview: String
    var releaseDate: String?
    var posterImage: UIImageView?
    var voteAverage: Double
    var posterPath: String?
    var didAction: (() -> Void)?
    var loadImage: ((String) -> UIImage)?
    
    var backComplition: ((UIImage) -> Void)?
    
    init() {
        self.title = "No Title"
        self.overview = "We don't have a synopsis"
        self.posterImage = UIImageView(image: UIImage(named: "no_image_holder"))
        self.voteAverage = 0.0
    }
}

extension MovieCellViewModel {

    init(movie: Movie, complition: @escaping (String) -> UIImage) {
        self.title = movie.title
        self.overview = movie.overview.isEmpty ? "We don't have a synopsis" : movie.overview
        self.posterImage = UIImageView()
        self.voteAverage = movie.voteAverage
        self.releaseDate = MovieCellViewModel.formattedDateFromString(dateString: movie.releaseDate)
        self.posterImage = UIImageView(image: UIImage(named: "no_image_holder"))
        self.posterPath = movie.posterPath
        
        self.loadImage = complition
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
