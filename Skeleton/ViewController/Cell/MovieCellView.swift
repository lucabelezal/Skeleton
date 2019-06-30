//
//  MovieCellView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
import UIKit

public class MovieViewCell: UICollectionViewCell {

    var containerView: UIView
    var imageView: UIImageView
    var captionLabel: UILabel
    var commentLabel: UILabel

    public override init(frame: CGRect) {
        self.containerView = UIView()
        self.imageView = UIImageView()
        self.captionLabel = UILabel()
        self.commentLabel = UILabel()
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieViewCell: ViewCodable {

    func configure() {
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true

        captionLabel.text = "Caption"
        commentLabel.text = "Comment"
    }

    func hierarchy() {
        containerView.addView(imageView, captionLabel, commentLabel)
        addView(containerView)
    }

    func constraints() {

        containerView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top)
            make.bottom.equalTo(self.layout.bottom)
            make.left.equalTo(self.layout.left)
            make.right.equalTo(self.layout.right)
        }

        imageView.layout.makeConstraints { make in
            make.top.equalTo(containerView.layout.top)
            make.bottom.equalTo(captionLabel.layout.bottom, constant: -8)
            make.left.equalTo(containerView.layout.left)
            make.right.equalTo(containerView.layout.right)
        }

        captionLabel.layout.makeConstraints { make in
            make.bottom.equalTo(commentLabel.layout.top)
            make.left.equalTo(containerView.layout.left)
            make.right.equalTo(containerView.layout.right)
        }

        commentLabel.layout.makeConstraints { make in
            make.bottom.equalTo(containerView.layout.bottom)
            make.left.equalTo(containerView.layout.left)
            make.right.equalTo(containerView.layout.right)
        }
    }

    func styles() {
        containerView.backgroundColor = .red
        imageView.backgroundColor = .purple
        captionLabel.backgroundColor = .green
        commentLabel.backgroundColor = .yellow
    }
}
