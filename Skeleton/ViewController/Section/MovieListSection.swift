//
//  MovieListSection.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public struct MovieListSection: TableSection {

    private var data: [MovieCellViewModelProtocol]
    public var numberOfRows: Int
    //public var rowHeight: CGFloat

    public var registerCell: (UITableView) -> Void = { tableView in
        tableView.register(cellType: MovieViewCell.self)
    }

    public var cellFactory: CellFactory {
        return { tableView, indexPath in
            let cell: MovieViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = self.data[indexPath.row]
            return cell
        }
    }

    public func didSelectRow(for indexPath: IndexPath) {
        let model = self.data[indexPath.row]
        model.didAction?()
    }

    // MARK: Private Methods

    private func renderCell(view: MovieViewCell) {}
}

public extension MovieListSection {

    init(data: [MovieCellViewModelProtocol]) {
        self.data = data
        self.numberOfRows = data.count
        //self.rowHeight = 120
    }
}
