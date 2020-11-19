import Foundation

public enum EnvironmentType {
    case qa
    case production
    case staging

    public var baseURL: String {
        switch self {
        case .production:
            return ConstantApi.productionUrl
        case .qa:
            return ConstantApi.qaUrl
        case .staging:
            return ConstantApi.stagingUrl
        }
    }
}
