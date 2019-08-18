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

    var networkManager: NetworkManager
    var isFetchInProgress: Bool
    var currentPage: Int

    private var movies: [Movie] {
        didSet {
            updateView()
        }
    }

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.movies = []
        self.isFetchInProgress = false
        self.currentPage = 0
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
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: Private Metthods

    private func loadData() {

        guard !isFetchInProgress else {
            return
        }

        isFetchInProgress = true
        self.networkManager.getNewMovies(page: 1) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch result {
                case .success(let data):
                    self.isFetchInProgress = false
                    self.currentPage = data.page
                    self.movies = data.movies
                case .failure(let error):
                    self.isFetchInProgress = false
                    print(error)
                }
            }
        }
    }

    private func loadImageData() {}

    private func updateView() {
        mainView.viewModel = MovieListViewModel(movies: movies)
    }
}
