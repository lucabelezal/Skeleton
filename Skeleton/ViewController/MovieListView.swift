//
//  MovieListView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
import UIKit

public class MovieListView: UIView {

    public let contentView: UIView
    public let tableView: UITableView
    private let dataSource: DataSource

    public var viewModel: MovieListViewModelProtocol? {
        didSet {
            update()
        }
    }

    public override init(frame: CGRect) {
        self.contentView = UIView()
        self.tableView = UITableView()
        self.dataSource = DataSource(tableView: tableView)
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func update() {
        let model = self.viewModel.unsafelyUnwrapped
        self.dataSource.sections = [MovieListSection(data: model.data)]
    }
}

extension MovieListView: ViewCodable {

    public func configure() {
        dataSource.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
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
        contentView.backgroundColor = .red
    }
}

extension MovieListView: DataSourceDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}
