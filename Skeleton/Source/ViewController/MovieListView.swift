//
//  MovieListView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
import UIKit

protocol MovieListViewDelegate: class {
    func prefetch(page: Int)
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

    // MARK: - Private Methods

    private func update() {
        tableView.reloadData()
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

extension MovieListView: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.items ?? 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(for: indexPath)
        cell.viewModel = viewModel?.data[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in

            let numberOfRows = tableView.numberOfRows(inSection: 0)

            if indexPath.row == numberOfRows - 5, let model = viewModel {
                delegate?.prefetch(page: model.nextPage)
            }
        }
    }
    
}
