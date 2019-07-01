//
//  MovieListViewController.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public class MovieListViewController: UIViewController {

    var networkManager: NetworkManager

    private var data: [Movie]? {
        didSet {
            updateView()
        }
    }

    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
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

        networkManager.getNewMovies(page: 1) { result in
            switch result {
            case .success(let data):
                self.data = data
            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateView() {

        if let mainView = self.view as? MovieListView, let movies = data {
            mainView.viewModel = MovieListViewModel(movies: movies)
        }
    }
}
