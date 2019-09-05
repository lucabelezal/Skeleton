//
//  MovieListView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
import SkeletonView
import UIKit

public protocol MovieListViewDelegate: class {
    func didReachToScrollBottom(is loading: Bool)
    func didPushToRefresh(is loading: Bool)
}

public class MovieListView: UIView {

    typealias Cell = TableViewCell<MovieCellView, MovieCellViewModelProtocol>

    public let tableView: UITableView

    public weak var delegate: MovieListViewDelegate?

    public var viewModel: MovieListViewModelProtocol? {
        didSet {
            update()
        }
    }

    public override init(frame: CGRect) {
        self.tableView = UITableView()
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MovieListView: ViewCodable {

    public func configure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.rowHeight = 278
        tableView.separatorStyle = .none
        tableView.register(cellType: Cell.self)
        isSkeletonable = true
        tableView.isSkeletonable = true
    }

    public func hierarchy() {
        addView(tableView)
    }

    public func constraints() {

        tableView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.safeArea.top)
            make.bottom.equalTo(self.layout.safeArea.bottom)
            make.left.equalTo(self.layout.left)
            make.right.equalTo(self.layout.right)
        }
    }

    public func styles() {
        backgroundColor = .lightGray
    }
}

extension MovieListView: DataSourceDelegate {

    public func fetchNextPage() {
         delegate?.didReachToScrollBottom(is: true)
    }

    public func cancelNextPage() {
         delegate?.didReachToScrollBottom(is: false)
    }

    public func loadData(forItemAtIndex: Int) {

    }

    public func cancelLoading(forItemAtIndex: Int) {

    }

    public func loadData(loading: Bool) {
        delegate?.didReachToScrollBottom(is: loading)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}

extension MovieListView: SkeletonTableViewDataSource, SkeletonTableViewDelegate, UITableViewDataSourcePrefetching {

    public func numSections(in collectionSkeletonView: UITableView) -> Int {
        return tableView.numberOfSections
    }

    public func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items ?? 0
    }

    public func collectionSkeletonView(_ skeletonView: UITableView,
                                       cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return Cell.reuseIdentifier
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(for: indexPath)
        cell.isSkeletonable = true
        cell.contentView.isSkeletonable = true
        cell.viewModel = viewModel?.data[indexPath.row]
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        indexPaths.forEach { indexPath in

            let count = tableView.numberOfRows(inSection: 0)

            if indexPath.row == count - 5 {
                delegate?.didReachToScrollBottom(is: true)
            }
        }
    }
}
