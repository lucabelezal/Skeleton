@testable
import Skeleton
import UIKit

extension Array where Element == MovieCellViewModelProtocol {
    static func mockList() -> [Element] {
        return [
            MovieCellViewModel(),
            MovieCellViewModel()
        ]
    }
}
