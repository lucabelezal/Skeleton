//
//  Movie.swift
//  Skeleton
//
//  Created by Malcolm Kumwenda on 2018/03/08.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

public struct Movie {
    let id: Int
    let posterPath: String?
    let backdropPath: String?
    let popularity: Double
    let title: String
    let releaseDate: String
    let rating: Double
    let overview: String
}

extension Movie: Codable {

    public enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case rating = "vote_average"
    }
}
