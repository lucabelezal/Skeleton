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

    var containerView: UIView
    var posterImageView: UIImageView
    var titleLabel: UILabel
    var overviewLabel: UILabel

    public var viewModel: MovieCellViewModelProtocol? {
        didSet {
            update()
        }
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.containerView = UIView()
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
        if let model = viewModel {
            posterImageView.image = model.image
            titleLabel.text = model.title
            overviewLabel.text = model.overview
        }
    }
}

extension MovieViewCell: ViewCodable {

    func configure() {
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true

        titleLabel.text = "Caption"
        titleLabel.numberOfLines = 0
        overviewLabel.text = "Comment"
        overviewLabel.numberOfLines = 2
    }

    func hierarchy() {
        containerView.addView(posterImageView, titleLabel, overviewLabel)
        addView(containerView)
    }

    func constraints() {

        containerView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top)
            make.bottom.equalTo(self.layout.bottom)
            make.left.equalTo(self.layout.left)
            make.right.equalTo(self.layout.right)
        }

        posterImageView.layout.makeConstraints { make in
            make.top.equalTo(containerView.layout.top)
            make.bottom.equalTo(titleLabel.layout.top)
            make.left.equalTo(containerView.layout.left)
            make.right.equalTo(containerView.layout.right)
            make.height.equalTo(constant: 50)
        }

        titleLabel.layout.makeConstraints { make in
            make.bottom.equalTo(overviewLabel.layout.top)
            make.left.equalTo(containerView.layout.left)
            make.right.equalTo(containerView.layout.right)
        }

        overviewLabel.layout.makeConstraints { make in
            make.bottom.equalTo(containerView.layout.bottom)
            make.left.equalTo(containerView.layout.left)
            make.right.equalTo(containerView.layout.right)
        }
    }

    func styles() {
        containerView.backgroundColor = .red
        posterImageView.backgroundColor = .purple
        titleLabel.backgroundColor = .green
        overviewLabel.backgroundColor = .yellow
    }
}
