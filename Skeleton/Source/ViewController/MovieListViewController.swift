//
//  MovieListViewController.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Networking
import UIKit

class MovieListViewController: UIViewController, AlertDisplayer {
    
    private var theView: MovieListView
    private var totalResults: Int
    private var movies: [Movie]
    private var service: MovieServiceProtocol
    private var currentPage: Int
    private var totalPages: Int
    private var isLoadInProgress: Bool
    
    init(service: MovieServiceProtocol) {
        self.service = service
        self.theView = MovieListView(frame: .zero)
        self.movies = []
        self.totalResults = 0
        self.currentPage = 1
        self.totalPages = 1
        self.isLoadInProgress = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        theView.delegate = self
        view = theView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadData()
    }
        
    // MARK: - Private Metthods
    
    private func configureView() {
        title = "Popular movies"
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
    }
    
    private func tryAgain(_ error: NetworkResponse) {
        self.isLoadInProgress = false
        self.stopLoading()
        let title = "Warning"
        let okAction = UIAlertAction(title: "OK", style: .default)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default) { _ in
            self.loadData()
        }
        self.displayAlert(with: title, message: error.description, actions: [okAction, tryAgainAction])
    }

    private func updateView(_ data: PopularMovies) {

        let isToReload = data.totalResults != totalResults

        totalResults = data.totalResults
        currentPage += 1
        isLoadInProgress = false
        totalPages = data.totalPages
        movies.append(contentsOf: data.movies)
        theView.viewModel = MovieListViewModel(with: data, and: self.movies, isToReloadTableView: isToReload)
        stopLoading()
    }

    private func loadData() {
        
        guard !isLoadInProgress else {
            return
        }
        
        isLoadInProgress = true
        
        startLoading()
                    
        service.popularMovies(page: self.currentPage, isRequestCanceled: false) { result in
            DispatchQueue.main.async { //asyncAfter(deadline: .now() + 4)
                switch result {
                case .success(let data):
                    self.updateView(data)
                case .failure(let error):
                    self.tryAgain(error)
                }
            }
        }
    }
}

extension MovieListViewController: MovieListViewDelegate {
    
    func fetchNextPage() {
        loadData()
    }
}
