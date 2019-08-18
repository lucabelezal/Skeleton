//
//  DataSource.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public protocol DataSourceDelegate: class {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

public class DataSource: NSObject {

    private let tableView: UITableView

    public weak var delegate: DataSourceDelegate?

    public var sections: [TableSection] {
        didSet {
            sections.forEach { $0.registerCell(tableView) }
            tableView.reloadData()
        }
    }

    public init(tableView: UITableView) {
        self.sections = []
        self.tableView = tableView
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.prefetchDataSource = self
    }

    public func appendSection(_ sections: [TableSection] ) {
        let last = IndexSet(integer: self.sections.count - 1)
        self.sections.append(contentsOf: sections)
        self.tableView.insertSections(last, with: .fade)
    }
}

extension DataSource: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        return section.cellFactory(tableView, indexPath)
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.title
    }
}

extension DataSource: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        cell.separatorInset = section.separatorInset(for: indexPath)
        cell.selectionStyle = .none
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        return section.headerFactory(tableView)
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section]
        return section.headerHeight
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        section.didSelectRow(for: indexPath)
    }
}

extension DataSource: UIScrollViewDelegate {

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
}

extension DataSource: UITableViewDataSourcePrefetching {

    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
}
