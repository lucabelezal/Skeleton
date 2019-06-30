//
//  MovieRouter.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public enum MovieRouter {
    case recommended(id:Int)
    case popular(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
}

extension MovieRouter: EndPointType {

    public var baseURL: URL {
        guard let url = URL(string: Environment.baseURL) else { fatalError("baseURL could not be configured.") }
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

    public var httpMethod: HttpMethod {
        return .get
    }

    public var task: HttpTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: [
                                        "page": page,
                                        "api_key": NetworkManager.MovieAPIKey,
                ])
        default:
            return .request
        }
    }

    public var headers: HttpHeaders? {
        return nil
    }
}
