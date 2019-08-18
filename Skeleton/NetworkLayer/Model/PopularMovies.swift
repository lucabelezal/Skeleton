//
//  PopularMovies.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

public struct PopularMovies {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    var movies: [Movie]
}

extension PopularMovies: Decodable {

    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movie].self, forKey: .movies)

    }
}
