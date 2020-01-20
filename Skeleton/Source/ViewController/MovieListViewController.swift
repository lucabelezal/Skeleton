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

    var theView: MovieListView {
        return self.view as! MovieListView // swiftlint:disable:this force_cast
    }

    private var movies: [Movie]
    
    private var data: PopularMovies? {
        didSet {
            updateView()
        }
    }

    private var service: MovieServiceProtocol
    private var currentPage: Int
    private var totalPages: Int
    private var isLoadInProgress: Bool
    
    init(service: MovieServiceProtocol) {
        self.service = service
        self.movies = []
        self.currentPage = 1
        self.totalPages = 1
        self.isLoadInProgress = false
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MovieListView(frame: .zero)
        theView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular movies"
        view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        loadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - Private Metthods

    private func loadData() {
        
        guard !isLoadInProgress else {
                   return
               }
               
        isLoadInProgress = true
        
        startLoading()
        
        service.popularMovies(page: self.currentPage, isRequestCanceled: false) { result in
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                switch result {
                case .success(let data):
                    self.stopLoading()
                    self.currentPage += 1
                    self.isLoadInProgress = false
                    self.totalPages = data.totalPages
                    
                    self.movies.append(contentsOf: data.movies)
                    self.data = data
                    
                case .failure(let error):
                    self.isLoadInProgress = false
                    self.stopLoading()
                    //TODO - displayAlert com try again no botão
                    fatalError("\(error)")
                }
            }
            
        }
    }

    private func updateView() {
        if let data = data {
          theView.viewModel = MovieListViewModel(with: data, and: movies)
        }
    }
}

extension MovieListViewController: MovieListViewDelegate {

    func fetchNextPage() {
        loadData()
    }

}
