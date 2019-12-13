//
//  CircleProgressView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 11/12/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
import UIKit

public class CircleProgressView: UIView {

    let contentView: UIView
    let percentageLabel: UILabel

    private let shapeLayer: CAShapeLayer

    public var progress: Float = 0 {
        didSet {
            update()
        }
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override init(frame: CGRect) {
        contentView = UIView()
        percentageLabel = UILabel()
        shapeLayer = CAShapeLayer()
        super.init(frame: frame)
        setupView()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        let centerPoint = CGPoint(x: rect.width / 2, y: rect.width / 2)
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero,
                                        radius: (rect.height / 2) - 4,
                                        startAngle: 0,
                                        endAngle: -.pi * 2,
                                        clockwise: false)

        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor(red: 239 / 255, green: 233 / 255, blue: 229 / 255, alpha: 1).cgColor
        trackLayer.lineWidth = 2.5
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        trackLayer.strokeEnd = 1
        trackLayer.position = centerPoint

        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 2.5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        shapeLayer.position = centerPoint
        shapeLayer.transform = CATransform3DMakeRotation(.pi * 1.5, 0, 0, 1)

        layer.addSublayer(trackLayer)
        layer.addSublayer(shapeLayer)

    }

    private func update() {

        if let value = percentageLabel.text {

            guard NSString(string: value).floatValue < 10.0 else {
                return
            }

            percentageLabel.text = "\(String(format: "%.1f", progress))%"

            if progress != NSString(string: value).floatValue {
                circleAnimation(fromValue: CGFloat(NSString(string: value).floatValue) / 10.0, toValue: CGFloat(progress) / 10.0)
            }

        } else {
            percentageLabel.text = "\(String(format: "%.1f", progress))%"
            circleAnimation(fromValue: 0.0, toValue: CGFloat(progress) / 10.0)
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

    func configure() {}

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
        percentageLabel.font = UIFont.systemFont(ofSize: 8, weight: UIFont.Weight.bold)
        percentageLabel.text = "0%"
        percentageLabel.textColor = .black
    }

    public func render() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

}
