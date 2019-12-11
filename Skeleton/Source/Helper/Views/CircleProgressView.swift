//
//  CircleProgressView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 11/12/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public class CircleProgressView: CALayer {
    
    private var circularPath: UIBezierPath!
    private var innerTrackShapeLayer: CAShapeLayer!
    private var outerTrackShapeLayer: CAShapeLayer!
    private let rotateTransformation = CATransform3DMakeRotation(-.pi / 2, 0, 0, 1)
    public var progressLabel: UILabel!
    public var isUsingAnimation: Bool!
    
    public var progress: Double = 0 {
        didSet {
            progressLabel.text = "\(String(format: "%.1f", progress))%"
            innerTrackShapeLayer.strokeEnd = CGFloat(progress / 10)
            if progress > 10 {
                progressLabel.text = "100%"
            }
        }
    }
    
    public init(radius: CGFloat, position: CGPoint, innerTrackColor: UIColor = #colorLiteral(red: 0.1294117647, green: 0.8156862745, blue: 0.4784313725, alpha: 1), outerTrackColor: UIColor = #colorLiteral(red: 0.004817033679, green: 0.004817033679, blue: 0.004817033679, alpha: 0.25), lineWidth: CGFloat) {
        super.init()
        
        circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        outerTrackShapeLayer = CAShapeLayer()
        outerTrackShapeLayer.path = circularPath.cgPath
        outerTrackShapeLayer.position = position
        outerTrackShapeLayer.strokeColor = outerTrackColor.cgColor
        outerTrackShapeLayer.fillColor = UIColor.clear.cgColor
        outerTrackShapeLayer.lineWidth = lineWidth
        outerTrackShapeLayer.strokeEnd = 1
        outerTrackShapeLayer.lineCap = CAShapeLayerLineCap.round
        outerTrackShapeLayer.transform = rotateTransformation
        addSublayer(outerTrackShapeLayer)
        
        innerTrackShapeLayer = CAShapeLayer()
        innerTrackShapeLayer.strokeColor = innerTrackColor.cgColor
        innerTrackShapeLayer.position = position
        innerTrackShapeLayer.strokeEnd = CGFloat(progress)
        innerTrackShapeLayer.lineWidth = lineWidth
        innerTrackShapeLayer.lineCap = CAShapeLayerLineCap.round
        innerTrackShapeLayer.fillColor = UIColor.clear.cgColor
        innerTrackShapeLayer.path = circularPath.cgPath
        innerTrackShapeLayer.transform = rotateTransformation
        addSublayer(innerTrackShapeLayer)
        
        progressLabel = UILabel()
        let size = CGSize(width: radius, height: radius)
        let origin = CGPoint(x: position.x, y: position.y)
        progressLabel.frame = CGRect(origin: origin, size: size)
        progressLabel.center = position
        progressLabel.center.y = position.y
        progressLabel.font = UIFont.systemFont(ofSize: 6, weight: UIFont.Weight.medium)
        progressLabel.text = "0%"
        progressLabel.textColor = .black
        progressLabel.textAlignment = .center
        insertSublayer(progressLabel.layer, at: 0)
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
