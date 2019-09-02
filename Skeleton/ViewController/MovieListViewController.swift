//
//  MovieListViewController.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import SkeletonView
import UIKit

public class MovieListViewController: UIViewController {

    public var mainView: MovieListView {
        return self.view as! MovieListView // swiftlint:disable:this force_cast
    }

    private var service: MovieServiceProtocol
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
    public init(service: MovieServiceProtocol) {
        self.service = service
        self.movies = []
        self.isFetchInProgress = false
        self.isNextPage = true
        self.currentPage = 1
        self.totalPages = 1
        self.isLoading = false
        self.isSearching = false
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        view = MovieListView(frame: .zero)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        loadData()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: Private Metthods

    private func loadData(pagination loadMore: Bool = false) {

        view.showAnimatedGradientSkeleton()

        if currentPage <= totalPages {

            guard !isFetchInProgress else {
                return
            }

            isFetchInProgress = true

            self.service.getNewMovies(page: currentPage, flag: isNextPage) { result in
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    switch result {
                    case .success(let data):
                        self.isFetchInProgress = false
                        self.currentPage = data.page
                        print("AQUI: - \(self.currentPage)")
                        self.totalPages = data.totalPages
                        self.movies.append(contentsOf: data.movies)

                        self.view.hideSkeleton()

                    case .failure(let error):
                        self.isFetchInProgress = false
                        print(error)

                        self.view.hideSkeleton()
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
