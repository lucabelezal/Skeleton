import LayoutKit
import UIKit

final class CircleProgressView: UIView {
    public var progress: Float = 0 {
        didSet {
            update()
        }
    }

    private let contentView: UIView
    private let percentageLabel: UILabel
    private let shapeLayer: CAShapeLayer

    private var color: UIColor {
        switch progress * 10 {
        case 1...39:
            return .red
        case 40...69:
            return .yellow
        case 70...100:
            return .green
        default:
            return .darkGray
        }
    }

    override init(frame: CGRect) {
        contentView = UIView()
        percentageLabel = UILabel()
        shapeLayer = CAShapeLayer()
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let centerPoint = CGPoint(x: rect.width / 2, y: rect.width / 2)
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(
            arcCenter: .zero,
            radius: (rect.height / 2) - 4,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: false
        )

        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor(red: 239 / 255, green: 233 / 255, blue: 229 / 255, alpha: 1).cgColor
        trackLayer.lineWidth = 2.5
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.strokeEnd = 1
        trackLayer.position = centerPoint

        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2.5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        shapeLayer.position = centerPoint
        shapeLayer.transform = CATransform3DMakeRotation(.pi * 1.5, 0, 0, 1)

        layer.addSublayer(trackLayer)
        layer.addSublayer(shapeLayer)
        
        layer.backgroundColor = UIColor.black.cgColor
        layer.cornerRadius = 21
    }

    private func update() {
        let progressValue = progress * 10
        shapeLayer.strokeColor = color.cgColor
        
        if let value = percentageLabel.text {

            if Int(progressValue) == 0 {
                percentageLabel.text = "NR"
                circleAnimation(fromValue: 0.0, toValue: 0.0)
            } else {
                percentageLabel.text = "\(Int(progressValue))%"
                circleAnimation(
                    fromValue: CGFloat(NSString(string: value).floatValue) / 100,
                    toValue: CGFloat(progressValue) / 100
                )
            }
        }
    }

    private func circleAnimation(fromValue: CGFloat, toValue: CGFloat) {
        let basicAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        basicAnimation.fromValue = fromValue
        basicAnimation.toValue = toValue
        basicAnimation.duration = 0.5
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "animateStrokeEnd")
    }

}

extension CircleProgressView: ViewCodable {
    public func hierarchy() {
        addView(contentView)
        contentView.addView(percentageLabel)
    }

    public func constraints() {
        contentView.layout.makeConstraints { make in
            make.top.equalTo(layout.top)
            make.left.equalTo(layout.left)
            make.right.equalTo(layout.right)
            make.bottom.equalTo(layout.bottom)
        }

        percentageLabel.layout.makeConstraints { make in
            make.top.equalTo(contentView.layout.top)
            make.left.equalTo(contentView.layout.left)
            make.right.equalTo(contentView.layout.right)
            make.bottom.equalTo(contentView.layout.bottom)
        }
    }

    public func styles() {
        percentageLabel.textAlignment = .center
        percentageLabel.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.bold)
        percentageLabel.text = "0.0%"
        percentageLabel.textColor = .white
    }

    public func render() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
