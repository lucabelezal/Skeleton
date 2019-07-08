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

    private var posterImageView: UIImageView
    private var titleLabel: UILabel
    private var overviewLabel: UILabel

    public var viewModel: MovieCellViewModelProtocol? {
        didSet {
            update()
        }
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
    }

    func hierarchy() {
        contentView.addView(posterImageView, titleLabel, overviewLabel)
    }

    func constraints() {
        posterImageView.layout.makeConstraints { make in
            make.top.equalTo(contentView.layout.top)
            make.bottom.equalTo(contentView.layout.bottom)
            make.left.equalTo(contentView.layout.left)
            make.width.equalTo(constant: 185)
        }

        titleLabel.layout.makeConstraints { make in
            make.top.equalTo(contentView.layout.top)
            make.right.equalTo(contentView.layout.right, constant: -8)
            make.left.equalTo(posterImageView.layout.right, constant: 8)
            make.height.equalTo(constant: 42)
        }

        overviewLabel.layout.makeConstraints { make in
            make.top.equalTo(titleLabel.layout.bottom, constant: 8)
            make.bottom.equalTo(contentView.layout.bottom, constant: -8)
            make.left.equalTo(titleLabel.layout.left)
            make.right.equalTo(titleLabel.layout.right)
        }
    }

    func styles() {
        contentView.backgroundColor = .red
        posterImageView.backgroundColor = .purple
        titleLabel.backgroundColor = .green
        overviewLabel.backgroundColor = .yellow
    }
}
