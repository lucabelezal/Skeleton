//
//  MovieListSection.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

struct MovieListSection: TableSection {

    typealias Cell = TableViewCell<MovieCellView, MovieCellViewModelProtocol>

    private var data: [MovieCellViewModelProtocol]
    var numberOfRows: Int

    var registerCell: (UITableView) -> Void = { tableView in
        tableView.register(cellType: Cell.self)
    }

    var cellFactory: CellFactory {
        return { tableView, indexPath in
            let cell: Cell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = self.data[indexPath.row]
            return cell
        }
    }

    func didSelectRow(for indexPath: IndexPath) {
        let model = self.data[indexPath.row]
        model.didAction?()
    }

    // MARK: - Private Methods

    private func renderCell(view: MovieCellView) {}
}

extension MovieListSection {

    init(data: [MovieCellViewModelProtocol]) {
        self.data = data
        self.numberOfRows = data.count
    }
    
}
