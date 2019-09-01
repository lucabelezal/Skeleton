//
//  MovieCellView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
import SkeletonView
import UIKit

public class MovieCellView: UIView, ViewModelOwner {

    private var contentView: UIView
    private var posterImageView: UIImageView
    private var titleLabel: UILabel
    private var overviewLabel: UILabel
    public var isSelected: Bool

    public var viewModel: MovieCellViewModelProtocol? {
        didSet {
            update()
        }
    }

    override init(frame: CGRect) {
        self.contentView = UIView()
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

extension MovieCellView: ViewCodable {

    func configure() {
        posterImageView.contentMode = .scaleAspectFit
        titleLabel.numberOfLines = 2
        overviewLabel.numberOfLines = 0

        isSkeletonable = true
        contentView.isSkeletonable = true
        posterImageView.isSkeletonable = true
        titleLabel.isSkeletonable = true
        overviewLabel.isSkeletonable = true
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
            make.top.equalTo(contentView.layout.top, constant: 8)
            make.bottom.equalTo(contentView.layout.bottom, constant: -8)
            make.left.equalTo(contentView.layout.left, constant: 8)
            make.width.equalTo(constant: 150)
            make.height.equalTo(constant: 180)
        }

        titleLabel.layout.makeConstraints { make in
            make.top.equalTo(posterImageView.layout.top)
            make.right.equalTo(contentView.layout.right, constant: -8)
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
        backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
        posterImageView.backgroundColor = .purple
        titleLabel.backgroundColor = .orange
        overviewLabel.backgroundColor = .yellow
    }
}
