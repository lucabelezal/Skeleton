import Foundation

public struct PopularMovies: Decodable {

    public let page, totalPages, totalResults: Int
    public let movies: [Movie]

    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
        movies = try container.decode([Movie].self, forKey: .movies)
    }
}
