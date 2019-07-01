//
//  MovieCellViewModel.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public protocol MovieCellViewModelProtocol {
    var image: UIImage { get }
    var title: String { get }
    var overview: String { get }
    var didAction: (() -> Void)? { get }
}

public struct MovieCellViewModel: MovieCellViewModelProtocol {

    public var image: UIImage
    public var title: String
    public var overview: String
    public var didAction: (() -> Void)?

    public init() {
        self.image = UIImage()
        self.title = String()
        self.overview = String()
    }
}

public extension MovieCellViewModel {

    init(movie: Movie) {
        self.image = UIImage()
        self.title = movie.title
        self.overview = movie.overview
    }
}
