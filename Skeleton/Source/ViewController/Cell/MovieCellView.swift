//
//  MovieCellView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 30/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
import UIKit

class MovieCellView: UIView, ViewModelOwner {
    
    private var contentView: CardView
    private var posterImageView: UIImageView
    private var titleLabel: UILabel
    private var overviewLabel: UILabel
    private var releaseDateLabel: UILabel
    private var containerView: UIView
    private var circleProgressView: CircleProgressView?
    
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
        self.releaseDateLabel = UILabel()
        self.isSelected = false
        self.containerView = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: 42))
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
            self.releaseDateLabel.text = model.releaseDate
            self.posterImageView.image = model.posterImage.image
            self.circleProgressView?.progress = model.voteAverage
        }
    }
    
}

extension MovieCellView: ViewCodable {
    
    func configure() {
        posterImageView.isSkeletonable = true
        titleLabel.isSkeletonable = true
        releaseDateLabel.isSkeletonable = true
        overviewLabel.isSkeletonable = true
        containerView.isSkeletonable = true
    }
    
    func hierarchy() {
        contentView.addView(titleLabel, releaseDateLabel, overviewLabel, containerView)
        addView(contentView, posterImageView)
        
        let xPosition = containerView.center.x
        let yPosition = containerView.center.y
        let position = CGPoint(x: xPosition, y: yPosition)
        
        circleProgressView = CircleProgressView(radius: 18, position: position, lineWidth: 4)
        if let progressView = circleProgressView {
             containerView.layer.addSublayer(progressView)
        }
    }
    
    func constraints() {
        
        contentView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top, constant: 48)
            make.bottom.equalTo(self.layout.bottom)
            make.left.equalTo(self.layout.left, constant: 16)
            make.right.equalTo(self.layout.right, constant: -16)
        }
        
        posterImageView.layout.makeConstraints { make in
            make.top.equalTo(self.layout.top, constant: 16)
            make.bottom.equalTo(contentView.layout.bottom)
            make.left.equalTo(contentView.layout.left)
            make.height.equalTo(constant: 204)
            make.width.equalTo(constant: 136)
        }
        
        containerView.layout.makeConstraints { make in
            make.top.equalTo(contentView.layout.top, constant: 8)
            make.left.equalTo(contentView.layout.left, constant: 144)
            make.height.equalTo(constant: 42)
            make.width.equalTo(constant: 42)
        }
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        titleLabel.layout.makeConstraints { make in
            make.top.equalTo(contentView.layout.top, constant: 8)
            make.right.equalTo(contentView.layout.right, constant: -8)
            make.left.equalTo(containerView.layout.right, constant: 8)
            make.height.lessThanOrEqualTo(constant: 42)
        }
        
        releaseDateLabel.layout.makeConstraints { make in
            make.top.equalTo(titleLabel.layout.bottom, constant: 4)
            make.right.equalTo(contentView.layout.right, constant: -8)
            make.left.equalTo(containerView.layout.right, constant: 8)
        }
        
        overviewLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        overviewLabel.layout.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.layout.bottom, constant: 8)
            make.bottom.lessThanOrEqualTo(contentView.layout.bottom, constant: -8)
            make.left.equalTo(posterImageView.layout.right, constant: 8)
            make.right.equalTo(releaseDateLabel.layout.right)
            make.height.lessThanOrEqualTo(constant: 110)
        }
    }
    
    func styles() {
        contentView.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 8
        posterImageView.layer.masksToBounds = true
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        
        releaseDateLabel.numberOfLines = 0
        releaseDateLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.light)
        
        overviewLabel.textColor = .darkGray
        overviewLabel.numberOfLines = 0
        overviewLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.medium)
    }
}
