//
//  MovieListView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
//import SkeletonView
import UIKit

protocol MovieListViewDelegate: class {
    func didReachToScrollBottom(is loading: Bool)
    func didPushToRefresh(is loading: Bool)
}

class MovieListView: UIView {

    typealias Cell = TableViewCell<MovieCellView, MovieCellViewModelProtocol>

    let tableView: UITableView

    weak var delegate: MovieListViewDelegate?

    var viewModel: MovieListViewModelProtocol? {
        didSet {
            update()
        }
    }

    override init(frame: CGRect) {
        self.tableView = UITableView()
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func update() {
        self.tableView.reloadData()
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }
}

extension MovieListView: ViewCodable {

    func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
//        tableView.rowHeight = 272
//        tableView.estimatedRowHeight = 272
        tableView.separatorStyle = .none
        tableView.register(cellType: Cell.self)
        //isSkeletonable = true
        //tableView.isSkeletonable = true
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
    }
}

//extension MovieListView: DataSourceDelegate {
//
//    func fetchNextPage() {
//         delegate?.didReachToScrollBottom(is: true)
//    }
//
//    func cancelNextPage() {
//         delegate?.didReachToScrollBottom(is: false)
//    }
//
//    func loadData(forItemAtIndex: Int) {
//
//    }
//
//    func cancelLoading(forItemAtIndex: Int) {
//
//    }
//
//    func loadData(loading: Bool) {
//        delegate?.didReachToScrollBottom(is: loading)
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//    }
//}

extension MovieListView: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {

    func numSections(in collectionSkeletonView: UITableView) -> Int {
        return tableView.numberOfSections
    }

//    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel?.items ?? 0
//    }
//
//    func collectionSkeletonView(_ skeletonView: UITableView,
//                                       cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
//        return Cell.reuseIdentifier
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(for: indexPath)
        //cell.isSkeletonable = true
        //cell.contentView.isSkeletonable = true
        cell.viewModel = viewModel?.data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        indexPaths.forEach { indexPath in

            let count = tableView.numberOfRows(inSection: 0)

            if indexPath.row == count - 5 {
                delegate?.didReachToScrollBottom(is: true)
            }
        }
    }
}
