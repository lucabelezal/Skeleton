import LayoutKit
import UIKit

final class MovieCellView: UIView, ViewModelOwner {
    
    private var contentView: CardView
    private var posterImageView: UIImageView
    private var titleLabel: UILabel
    private var overviewLabel: UILabel
    private var releaseDateLabel: UILabel
    private var containerView: UIView
    private var circleProgressView: CircleProgressView
    
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
        self.containerView = UIView()
        self.circleProgressView = CircleProgressView()
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        if let model = viewModel {
            titleLabel.text = model.title
            overviewLabel.text = model.overview
            releaseDateLabel.text = model.releaseDate
            posterImageView.image = model.posterImage?.image
            circleProgressView.progress = Float(model.voteAverage)
            circleProgressView.isHidden = false
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
        circleProgressView.isSkeletonable = true
        circleProgressView.isHidden = true
    }
    
    func hierarchy() {
        containerView.addView(circleProgressView)
        contentView.addView(titleLabel, releaseDateLabel, overviewLabel, containerView)
        addView(contentView, posterImageView)
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
        
        circleProgressView.layout.makeConstraints { make in
            make.top.equalTo(containerView.layout.top)
            make.bottom.equalTo(containerView.layout.bottom)
            make.left.equalTo(containerView.layout.left)
            make.right.equalTo(containerView.layout.right)
        }
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        titleLabel.layout.makeConstraints { make in
            make.top.equalTo(contentView.layout.top, constant: 8)
            make.right.equalTo(contentView.layout.right, constant: -8)
            make.left.equalTo(containerView.layout.right, constant: 8)
            make.height.lessThanOrEqualTo(constant: 42)
        }
        
        releaseDateLabel.layout.makeConstraints { make in
            make.top.equalTo(titleLabel.layout.bottom, constant: 8)
            make.bottom.equalTo(overviewLabel.layout.top, constant: -8)
            make.right.equalTo(contentView.layout.right, constant: -8)
            make.left.equalTo(containerView.layout.right, constant: 8)
            make.height.equalTo(constant: 16)
        }
        
        overviewLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        overviewLabel.layout.makeConstraints { make in
            make.top.greaterThanOrEqualTo(circleProgressView.layout.bottom, constant: 8)
            make.bottom.lessThanOrEqualTo(contentView.layout.bottom, constant: -8)
            make.left.equalTo(posterImageView.layout.right, constant: 8)
            make.right.equalTo(releaseDateLabel.layout.right)
            make.height.lessThanOrEqualTo(constant: 116)
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
