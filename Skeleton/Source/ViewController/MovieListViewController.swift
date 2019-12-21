//
//  MovieListViewController.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Networking
import UIKit

class MovieListViewController: UIViewController {

    var mainView: MovieListView {
        return self.view as! MovieListView // swiftlint:disable:this force_cast
    }

    private var service: MovieServiceProtocol

    private var currentPage: Int
    private var totalPages: Int
    private var isLoading: Bool

    private var movies: [Movie] {
        didSet {
            updateView()
        }
    }

    init(service: MovieServiceProtocol) {
        self.service = service
        self.movies = []
        self.currentPage = 1
        self.totalPages = 1
        self.isLoading = false
        
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
        title = "Popular movies"
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        loadData(at: currentPage)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Private Metthods

    private func loadData(at page: Int) {
        
        startLoading()
        
        service.popularMovies(page: page, isRequestCanceled: false) { result in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                switch result {
                case .success(let data):
                    self.stopLoading()
                    self.currentPage = data.page
                    self.totalPages = data.totalPages
                    self.movies.append(contentsOf: data.movies)
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }

    private func loadImageData() {}

    private func updateView() {
        mainView.delegate = self
        mainView.viewModel = MovieListViewModel(movies: movies, page: currentPage, totalPages: totalPages)
    }
}

extension MovieListViewController: MovieListViewDelegate {

    func prefetch(page: Int) {
        loadData(at: page)
    }

}
