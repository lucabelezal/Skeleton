//
//  MovieListViewController.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public class MovieListViewController: UIViewController {

    public var mainView: MovieListView {
        return self.view as! MovieListView // swiftlint:disable:this force_cast
    }

    private var networkManager: NetworkManager
    private var isFetchInProgress: Bool
    private var isNextPage: Bool
    private var isSearching: Bool
    private var totalPages: Int
    private var currentPage: Int
    private var isLoading: Bool

    private var movies: [Movie] {
        didSet {
            currentPage += 1
            updateView()
        }
    }

    var isAnimateStart: Bool = false
    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.movies = []
        self.isFetchInProgress = false
        self.isNextPage = true
        self.currentPage = 1
        self.totalPages = 1
        self.isLoading = false
        self.isSearching = false
        super.init(nibName: nil, bundle: nil)
        self.loadData()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        self.view = MovieListView(frame: .zero)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LoadingShimmer.startCovering(mainView.tableView)
    }

    // MARK: Private Metthods

    private func loadData(pagination loadMore: Bool = false) {

        if currentPage <= totalPages {

            guard !isFetchInProgress else {
                return
            }

            isFetchInProgress = true

            self.networkManager.getNewMovies(page: currentPage, flag: isNextPage) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self.isFetchInProgress = false
                        self.currentPage = data.page
                        print("AQUI: - \(self.currentPage)")
                        self.totalPages = data.totalPages
                        self.movies.append(contentsOf: data.movies)
                    case .failure(let error):
                        self.isFetchInProgress = false
                        print(error)
                    }
                }
            }
        }
    }

    private func loadImageData() {}

    private func updateView() {
        mainView.viewModel = MovieListViewModel(movies: movies)
    }
}

extension MovieListViewController: MovieListViewDelegate {

    public func didReachToScrollBottom(is loading: Bool) {
        isNextPage = loading
        loadData()
    }

    public func didPushToRefresh(is loading: Bool) {

    }
}
