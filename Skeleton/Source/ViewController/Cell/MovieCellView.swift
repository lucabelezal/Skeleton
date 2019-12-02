//
//  MovieCellView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
//import SkeletonView
import UIKit

class MovieCellView: UIView, ViewModelOwner {

    private var contentView: CardView
    private var posterImageView: UIImageView
    private var titleLabel: UILabel
    private var overviewLabel: UILabel
    var isSelected: Bool

    var viewModel: MovieCellViewModelProtocol? {
        didSet {
            update()
        }
    }

    override init(frame: CGRect) {
        self.contentView = CardView()
        self.posterImageView = UIImageView()
        self.titleLabel = UILabel()
        self.overviewLabel = UILabel()
        self.isSelected = false
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {
        if let model = self.viewModel {
            self.titleLabel.text = model.title
            self.overviewLabel.text = model.overview
            self.posterImageView.image = model.posterImage.image
        }
    }
}

extension MovieCellView: ViewCodable {

    func configure() {
        posterImageView.contentMode = .scaleAspectFill
        titleLabel.numberOfLines = 0
        overviewLabel.numberOfLines = 0

        //shimmerAnimation = true
        //contentView.shimmerAnimation = true
        posterImageView.shimmerAnimation = true
        titleLabel.shimmerAnimation = true
        overviewLabel.shimmerAnimation = true

        //isSkeletonable = true
        //contentView.isSkeletonable = true
        //posterImageView.isSkeletonable = true
        //titleLabel.isSkeletonable = true
        //overviewLabel.isSkeletonable = true
    }

    func hierarchy() {
        contentView.addView(posterImageView, titleLabel, overviewLabel)
        addView(contentView)
    }

    func constraints() {

        contentView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top, constant: 16)
            make.bottom.equalTo(self.layout.bottom, constant: -16)
            make.left.equalTo(self.layout.left, constant: 16)
            make.right.equalTo(self.layout.right, constant: -16)
        }

        posterImageView.layout.makeConstraints { make in
            make.top.equalTo(contentView.layout.top)
            make.bottom.equalTo(contentView.layout.bottom)
            make.left.equalTo(contentView.layout.left)
            make.width.equalTo(constant: 160)
        }

        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.layout.makeConstraints { make in
            make.top.equalTo(contentView.layout.top, constant: 8)
            make.right.equalTo(contentView.layout.right, constant: -8)
            make.left.equalTo(posterImageView.layout.right, constant: 8)
        }

        overviewLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        overviewLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        overviewLabel.layout.makeConstraints { make in
            make.top.equalTo(titleLabel.layout.bottom, constant: 8)
            make.bottom.lessThanOrEqualTo(contentView.layout.bottom, constant: -8)
            make.left.equalTo(titleLabel.layout.left)
            make.right.equalTo(titleLabel.layout.right)
        }
    }

    func styles() {
        backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        overviewLabel.textColor = .darkGray
    }
}
