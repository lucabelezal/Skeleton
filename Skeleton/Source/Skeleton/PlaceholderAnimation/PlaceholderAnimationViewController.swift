////
////  PlaceholderAnimationViewController.swift
////  Skeleton
////
////  Created by Lucas Nascimento on 06/12/19.
////  Copyright © 2019 Lucas Nascimento. All rights reserved.
////
//
//import UIKit
//
////PlaceholderAnimation
//
//var associateObjectValuePlaceholderAnimation: Int = 0 // swiftlint:disable:this identifier_name
//
//extension UIView {
//
//    fileprivate var isAnimate: Bool {
//        get {
//            return objc_getAssociatedObject(self, &associateObjectValuePlaceholderAnimation) as? Bool ?? false
//        }
//        set {
//            return objc_setAssociatedObject(self, &associateObjectValuePlaceholderAnimation, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//
//    @IBInspectable var shimmerAnimationPlaceholderAnimation: Bool { // swiftlint:disable:this identifier_name
//        get {
//            return isAnimate
//        }
//        set {
//            self.isAnimate = newValue
//        }
//    }
//
//    func subviewsRecursivePlaceholderAnimation() -> [UIView] {
//        return subviews + subviews.flatMap { $0.subviewsRecursivePlaceholderAnimation() }
//    }
//}
//
///// ViewController
//class PlaceholderAnimationViewController: UIViewController {
//
//    /// IBOutlet(s)
//    @IBOutlet weak var tableView: UITableView!
//
//    /// Variable Declaration(s)
//    var isAnimateStart: Bool = false
//
//    /// View Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        prepareUI()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        startPlaceholderAnimation()
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//}
//
//extension PlaceholderAnimationViewController {
//
//    func prepareUI() {
//
//    }
//}
//
//extension PlaceholderAnimationViewController {
//
//    func startPlaceholderAnimation() {
//        for animateView in getSubViewsForPlaceholderAnimate() {
//                        animateView.clipsToBounds = true
//            let gradientLayer = CAGradientLayer()
//            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.withAlphaComponent(0.8).cgColor, UIColor.clear.cgColor]
//            gradientLayer.startPoint = CGPoint(x: 0.7, y: 1.0)
//            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
//            gradientLayer.frame = animateView.bounds
//            animateView.layer.mask = gradientLayer
//            
//            let animation = CABasicAnimation(keyPath: "transform.translation.x")
//            animation.duration = 1.5
//            animation.fromValue = -animateView.frame.size.width
//            animation.toValue = animateView.frame.size.width
//            animation.repeatCount = .infinity
//            
//            gradientLayer.add(animation, forKey: "")
//        }
//    }
//
//    func stopPlaceholderAnimation() {
//        for animateView in getSubViewsForPlaceholderAnimate() {
//            animateView.layer.removeAllAnimations()
//            animateView.layer.mask = nil
//            //self.gradientLayer.removeAllAnimations()
//        }
//    }
//}
//
//extension PlaceholderAnimationViewController {
//
//    func getSubViewsForPlaceholderAnimate() -> [UIView] {
//        var obj: [UIView] = []
//        for objView in view.subviewsRecursivePlaceholderAnimation() {
//            obj.append(objView)
//        }
//        return obj.filter({ (obj) -> Bool in
//            obj.shimmerAnimationPlaceholderAnimation
//        })
//    }
//}
//
//extension PlaceholderAnimationViewController {
//
//    @IBAction func tapBtnRefresh(_ sender: UIBarButtonItem) {
//        if isAnimateStart {
//            startPlaceholderAnimation()
//            sender.title = "Stop"
//        } else {
//            stopPlaceholderAnimation()
//            sender.title = "Start"
//        }
//        isAnimateStart = !isAnimateStart
//    }
//}
//
//extension PlaceholderAnimationViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
