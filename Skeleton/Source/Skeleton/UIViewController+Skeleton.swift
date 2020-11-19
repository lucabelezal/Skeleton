import UIKit

public extension UIViewController {
    func startLoading() {
        DispatchQueue.main.async {
            for animateView in self.getSubViewsForAnimate() {
                
                animateView.layoutIfNeeded()
                
                let colorLayer = CALayer()
                colorLayer.backgroundColor = UIColor(white: 0.82, alpha: 1).cgColor
                colorLayer.frame = animateView.maxBoundsEstimated
                colorLayer.name = "colorLayer"
                animateView.layer.addSublayer(colorLayer)
                animateView.autoresizesSubviews = true
                animateView.clipsToBounds = true
                
                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = [
                    UIColor(white: 0.82, alpha: 1).cgColor,
                    UIColor(white: 0.86, alpha: 1).cgColor,
                    UIColor(white: 0.82, alpha: 1).cgColor,
                ]
                
                gradientLayer.locations = [0, 0.4, 0.8, 1]
                gradientLayer.name = "gradientLayer"
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                gradientLayer.frame = animateView.maxBoundsEstimated
                animateView.layer.addSublayer(gradientLayer)
                
                let pulseAnimation = CABasicAnimation(keyPath: "transform.translation.x")
                pulseAnimation.duration = 1.2
                pulseAnimation.fromValue = -animateView.frame.width
                pulseAnimation.toValue = animateView.frame.width
                pulseAnimation.repeatCount = .infinity
                gradientLayer.add(pulseAnimation, forKey: "smartLoader")
            }
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            for animateView in self.getSubViewsForAnimate() {
                if let smartLayers = animateView.layer.sublayers?.filter({ $0.name == "colorLayer" || $0.name == "gradientLayer" }) {
                    smartLayers.forEach { $0.removeFromSuperlayer() }
                }
            }
        }
    }
    
}

private extension UIViewController {
    
    func getSubViewsForAnimate() -> [UIView] {
        var obj: [UIView] = []
        for objView in view.subviewsRecursive() {
            obj.append(objView)
        }
        return obj.filter { (obj) -> Bool in
            obj.isSkeletonable
        }
    }
    
}
