//
//  MovieListViewController.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Networking
//import SkeletonView
import UIKit

class MovieListViewController: UIViewController {

    var mainView: MovieListView {
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
    init(service: MovieServiceProtocol) {
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MovieListView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filmes populares"
        mainView.delegate = self
        loadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: Private Metthods

    private func loadData(pagination loadMore: Bool = false) {

        if currentPage <= totalPages {

            guard !isFetchInProgress else {
                return
            }

            isFetchInProgress = true
            //view.showAnimatedGradientSkeleton()
            //self.startAnimation()
            
            startShimmerAnimation()

            self.service.popularMovies(page: currentPage, flag: isNextPage) { result in
                DispatchQueue.main.async { //asyncAfter(deadline: .now() + 4)
                    switch result {
                    case .success(let data):
                        self.isFetchInProgress = false
                        //self.stopAnimation()
                        self.currentPage = data.page
                        print("AQUI: - \(self.currentPage)")
                        self.totalPages = data.totalPages
                        self.movies.append(contentsOf: data.movies)

                        //self.view.hideSkeleton()

                    case .failure(let error):
                        self.isFetchInProgress = false
                        //self.stopAnimation()
                        print(error)
                        //self.view.hideSkeleton()
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

    func didReachToScrollBottom(is loading: Bool) {
        isNextPage = loading
        loadData()
    }

    func didPushToRefresh(is loading: Bool) {

    }
}
