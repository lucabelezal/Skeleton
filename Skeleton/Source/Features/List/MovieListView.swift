import LayoutKit
import UIKit

protocol MovieListViewDelegate: class {
    func fetchNextPage()
}

final class MovieListView: UIView {
    
    typealias Cell = TableViewCell<MovieCellView, MovieCellViewModelProtocol>

    weak var delegate: MovieListViewDelegate?

    var viewModel: MovieListViewModelProtocol {
        didSet {
            update()
        }
    }

    private let tableView: UITableView

    override init(frame: CGRect) {
        self.viewModel = MovieListViewModel()
        self.tableView = UITableView()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func update() {
        self.tableView.reloadData()
    }

    private func reloadRow(at indexPath: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .none)
        self.tableView.endUpdates()
    }
    
}

extension MovieListView: ViewCodable {
    
    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.separatorStyle = .none
        tableView.register(cellType: Cell.self)
    }
    
    func hierarchy() {
        addView(tableView)
    }
    
    func constraints() {
        
        tableView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.safeArea.top)
            make.bottom.equalTo(self.layout.safeArea.bottom)
            make.left.equalTo(self.layout.left)
            make.right.equalTo(self.layout.right)
        }
    }
    
    func styles() {
        backgroundColor = .lightGray
        tableView.backgroundColor = .clear
    }
    
}

extension MovieListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(for: indexPath)
        if isLoadingCell(for: indexPath) {
            cell.viewModel = MovieCellViewModel()
        } else {
            cell.viewModel = viewModel.movieModel(indexPath.row)
        }
        return cell
    }
}

extension MovieListView: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            delegate?.fetchNextPage()
        }
    }
}

extension MovieListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

private extension MovieListView {
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
