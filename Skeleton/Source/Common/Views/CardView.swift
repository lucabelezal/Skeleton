import UIKit

final class CardView: UIView {
    override func layoutSubviews() {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 12.0
        layer.shadowOpacity = 0.7
    }
    
}
