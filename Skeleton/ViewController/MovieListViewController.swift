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

    private var isLoading: Bool {
        didSet {
            updateView()
        }
    }

    private var data: [Movie] {
        didSet {
            updateView()
        }
    }

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        self.data = []
        self.isLoading = false
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        self.view = MovieListView(frame: .zero)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: Private Metthods

    private func loadData() {

        isLoading = true

        networkManager.getNewMovies(page: 1) { result in
            switch result {
            case .success(let data):
                self.data = data
                self.isLoading = false
            case .failure(let error):
                self.isLoading = false
                print(error)
            }
        }
    }

    private func loadImageData() {

        //        networkManager.getNewMovies(page: 1) { result in
        //            switch result {
        //            case .success(let data):
        //                self.data = data
        //            case .failure(let error):
        //                print(error)
        //            }
        //        }
    }
    
    private func updateView() {

        mainView.viewModel = MovieListViewModel(movies: data, isLoading: isLoading)
        //        if let mainView = self.view as? MovieListView, let movies = data {
        //            mainView.viewModel = MovieListViewModel(movies: movies, isLoading: isLoading)
        //        }
    }
}
