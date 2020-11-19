import Foundation

public struct Movie: Codable {

    public let id: Int
    public let backdropPath, posterPath: String?
    public let voteAverage, popularity: Double
    public let title, releaseDate, overview: String

    public enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
