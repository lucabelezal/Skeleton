@testable
import Skeleton
import XCTest

class MovieListSectionTests: XCTestCase {
    typealias Cell = TableViewCell<MovieCellView, MovieCellViewModelProtocol>

    var sut: MovieListSection!
    var tableView: UITableView!
    var indexPath: IndexPath!

    override func setUp() {
        sut = MovieListSection(data: .mockList())
        tableView = UITableView()
        tableView.register(cellType: Cell.self)
        indexPath = IndexPath(row: 0, section: 0)
    }

    override func tearDown() {
        sut = nil
        tableView = nil
        indexPath = nil
    }

    func test_numberOfRows() {
        XCTAssertEqual(sut.numberOfRows, 2)
    }

    func test_cellFactory() {
        let cell = sut.cellFactory(tableView, indexPath)
        XCTAssert(cell is Cell)
    }
}
