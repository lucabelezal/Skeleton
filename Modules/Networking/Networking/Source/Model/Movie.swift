//
//  Movie.swift
//  Networking
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    public let id: Int
    public let posterPath: String?
    public let backdropPath: String?
    public let popularity: Double
    public let title: String
    public let releaseDate: String
    public let rating: Double
    public let overview: String

    public enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case rating = "vote_average"
    }
}