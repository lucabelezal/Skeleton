//
//  SkeletonViewExtension.swift
//  SkeletonView
//
//  Created by Caio Ortu on 18/03/19.
//  Copyright © 2019 Caio Ortu. All rights reserved.
//

import UIKit

extension SkeletonView {
    enum Constants {
        static let becomeActiveNotification = UIApplication.didBecomeActiveNotification
        static let enterForegroundNotification = UIApplication.didEnterBackgroundNotification
        static let needAnimatedSkeletonKey = "needAnimateSkeleton"
    }
    
    func addAppNotificationsObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: Constants.becomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: Constants.enterForegroundNotification, object: nil)
    }
    
    func removeAppNoticationsObserver() {
        NotificationCenter.default.removeObserver(self, name: Constants.becomeActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: Constants.enterForegroundNotification, object: nil)
    }
    
    @objc func appDidBecomeActive() {
        if UserDefaults.standard.bool(forKey: Constants.needAnimatedSkeletonKey) {
            restartSkeleton()
        }
    }
    
    @objc func appDidEnterBackground() {
        UserDefaults.standard.set((isSkeletonActive && isAnimated), forKey: Constants.needAnimatedSkeletonKey)
    }
}
