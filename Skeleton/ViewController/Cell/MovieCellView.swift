//
//  MovieCellView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
import UIKit

public class MovieViewCell: UITableViewCell, Reusable {

    private var contentsView: UIView
    private var posterImageView: UIImageView
    private var titleLabel: UILabel
    private var overviewLabel: UILabel

    public var viewModel: MovieCellViewModelProtocol? {
        didSet {
            update()
        }
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.contentsView = UIView()
        self.posterImageView = UIImageView()
        self.titleLabel = UILabel()
        self.overviewLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func update() {
        DispatchQueue.main.async {
            if let model = self.viewModel {
                self.titleLabel.text = model.title
                self.overviewLabel.text = model.overview
                self.posterImageView.image = model.posterImage.image
            }
        }
    }
}

extension MovieViewCell: ViewCodable {

    func configure() {
        posterImageView.contentMode = .scaleAspectFit
        titleLabel.numberOfLines = 2
        overviewLabel.numberOfLines = 0
    }

    func hierarchy() {
        contentsView.addView(posterImageView, titleLabel, overviewLabel)
        addView(contentsView)
    }

    func constraints() {

        contentsView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top, constant: 16)
            make.bottom.equalTo(self.layout.bottom, constant: -16)
            make.left.equalTo(self.layout.left, constant: 16)
            make.right.equalTo(self.layout.right, constant: -16)
        }

        posterImageView.layout.makeConstraints { make in
            make.top.equalTo(contentsView.layout.top, constant: 8)
            make.bottom.equalTo(contentsView.layout.bottom, constant: -8)
            make.left.equalTo(contentsView.layout.left, constant: 8)
            make.width.equalTo(constant: 150)
            make.height.equalTo(constant: 180)
        }

        titleLabel.layout.makeConstraints { make in
            make.top.equalTo(posterImageView.layout.top)
            make.right.equalTo(contentsView.layout.right, constant: -8)
            make.left.equalTo(posterImageView.layout.right, constant: 8)
        }

        overviewLabel.layout.makeConstraints { make in
            make.top.equalTo(titleLabel.layout.bottom, constant: 8)
            make.bottom.lessThanOrEqualTo(posterImageView.layout.bottom)
            make.left.equalTo(titleLabel.layout.left)
            make.right.equalTo(titleLabel.layout.right)
        }
    }

    func styles() {
        backgroundColor = .white
        contentsView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        posterImageView.backgroundColor = .purple
        titleLabel.backgroundColor = .green
        overviewLabel.backgroundColor = .yellow
    }
}
