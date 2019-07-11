//
//  MovieCellView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Kingfisher
import LayoutKit
import UIKit

public class MovieViewCell: UITableViewCell, Reusable {

    private var skeletonView: UIView
    private var posterImageView: UIImageView
    private var titleLabel: UILabel
    private var overviewLabel: UILabel

    public var viewModel: MovieCellViewModelProtocol? {
        didSet {
            update()
        }
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.skeletonView = UIView()
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
        let model = viewModel.unsafelyUnwrapped
        let url = URL(string: model.path)
        posterImageView.kf.setImage(with: url)
        titleLabel.text = model.title
        overviewLabel.text = model.overview
    }
}

extension MovieViewCell: ViewCodable {

    func configure() {
        posterImageView.contentMode = .scaleAspectFit
        titleLabel.numberOfLines = 2
        overviewLabel.numberOfLines = 0

        skeletonView.layer.cornerRadius = 14.0
        skeletonView.layer.shadowColor = UIColor.darkGray.cgColor
        skeletonView.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        skeletonView.layer.shadowRadius = 6.0
        skeletonView.layer.shadowOpacity = 0.6
    }

    func hierarchy() {
        skeletonView.addView(posterImageView, titleLabel, overviewLabel)
        addView(skeletonView)
    }

    func constraints() {

        skeletonView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top, constant: 16)
            make.bottom.equalTo(self.layout.bottom, constant: -16)
            make.left.equalTo(self.layout.left, constant: 16)
            make.right.equalTo(self.layout.right, constant: -16)
        }

        posterImageView.layout.makeConstraints { make in
            make.top.equalTo(skeletonView.layout.top, constant: 8)
            make.bottom.equalTo(skeletonView.layout.bottom, constant: -8)
            make.left.equalTo(skeletonView.layout.left, constant: 8)
            make.width.equalTo(constant: 153)
        }

        titleLabel.layout.makeConstraints { make in
            make.top.equalTo(skeletonView.layout.top, constant: 8)
            make.right.equalTo(skeletonView.layout.right, constant: -8)
            make.left.equalTo(posterImageView.layout.right, constant: 8)
            make.height.equalTo(constant: 42)
        }

        overviewLabel.layout.makeConstraints { make in
            make.top.equalTo(titleLabel.layout.bottom, constant: 8)
            make.bottom.equalTo(skeletonView.layout.bottom, constant: -8)
            make.left.equalTo(titleLabel.layout.left)
            make.right.equalTo(titleLabel.layout.right)
        }
    }

    func styles() {
        backgroundColor = .white
        skeletonView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        posterImageView.backgroundColor = .purple
        titleLabel.backgroundColor = .green
        overviewLabel.backgroundColor = .yellow
    }
}
