import Networking

public enum MovieRouter {
    case recommended(id: Int)
    case popular(page: Int)
    case newMovies(page: Int)
    case video(id: Int)
}

extension MovieRouter: EndpointType {

    public var baseURL: URL {
        guard let base = NetworkManager.baseURL, let url = URL(string: base) else {
                fatalError("baseURL could not be configured.")
        }
        return url
    }

    public var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }

    public var httpMethod: HTTPMethod {
        return .get
    }

    public var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page": page, "api_key": ConstantApi.apiKey])
        default:
            return .request
        }
    }

    public var headers: HTTPHeaders? {
        return nil
    }
}
