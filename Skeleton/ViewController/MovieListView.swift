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
    private let tableView: UITableView
    private let dataSource: DataSource?

    public var viewModel: MovieListViewModelProtocol? {
        didSet {
            update()
        }
    }

    public override init(frame: CGRect) {
        self.contentView = UIView()
        self.tableView = UITableView(frame: .zero)
        self.dataSource = DataSource(tableView: tableView)
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private Methods

    private func update() {
        if let model = viewModel {
            dataSource?.sections = [MovieListSection(data: model.data)]
        }
    }
}

extension MovieListView: ViewCodable {

    func configure() {}

    func hierarchy() {
        contentView.addView(tableView)
        addView(contentView)
    }

    func constraints() {

        contentView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top)
            make.bottom.equalTo(self.layout.bottom)
            make.left.equalTo(self.layout.left)
            make.right.equalTo(self.layout.right)
        }

        tableView.layout.makeConstraints { make in
            make.top.equalTo(contentView.layout.safeArea.top)
            make.bottom.equalTo(contentView.layout.safeArea.bottom)
            make.left.equalTo(contentView.layout.left)
            make.right.equalTo(contentView.layout.right)
        }
    }

    func styles() {
//        contentView.backgroundColor = .clear
    }
}
