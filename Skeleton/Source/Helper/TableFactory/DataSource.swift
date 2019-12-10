//
//  DataSource.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

protocol DataSourceDelegate: class {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    func loadData(loading: Bool)
    func loadData(forItemAtIndex: Int)
    func cancelLoading(forItemAtIndex: Int)
    func fetchNextPage()
    func cancelNextPage()
}

class DataSource: NSObject {

    private let tableView: UITableView

    weak var delegate: DataSourceDelegate?

    var sections: [TableSection] {
        didSet {
            sections.forEach { $0.registerCell(tableView) }
            tableView.reloadData()
        }
    }

    init(tableView: UITableView) {
        self.sections = []
        self.tableView = tableView
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.prefetchDataSource = self
    }

    func appendSection(_ sections: [TableSection] ) {
        let last = IndexSet(integer: self.sections.count - 1)
        self.sections.append(contentsOf: sections)
        self.tableView.insertSections(last, with: .fade)
    }
    
}

extension DataSource: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        return section.cellFactory(tableView, indexPath)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.title
    }
    
}

extension DataSource: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        cell.separatorInset = section.separatorInset(for: indexPath)
        cell.selectionStyle = .none
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        return section.headerFactory(tableView)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        return section.headerHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.didSelectRow(for: indexPath)
    }
    
}

extension DataSource: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
    
}

extension DataSource: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        indexPaths.forEach { indexPath in

            let count = tableView.numberOfRows(inSection: 0)

            if indexPath.row == count - 5 {
                delegate?.fetchNextPage()
            }
        }
    }
    
}
