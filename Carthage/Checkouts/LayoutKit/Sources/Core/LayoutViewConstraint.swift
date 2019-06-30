//
//  LayoutViewConstraint.swift
//  LayoutKit
//
//  Created by Vinicius França on 29/09/18.
//  Copyright © 2018 Vinicius França. All rights reserved.
//

import Foundation

public class LayoutViewConstraint {

    internal let view: LayoutView

    internal required init(view: LayoutView) {
        self.view = view
    }

    public func makeConstraints(_ completion: (_ make: LayoutConstraintMaker) -> Void) {
        completion(LayoutConstraintMaker(view: configureTranslatesAutoresizing(view)))
    }

    internal func configureTranslatesAutoresizing(_ view: LayoutView) -> LayoutView {
        if view.translatesAutoresizingMaskIntoConstraints {
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
        return view
    }

}

public extension LayoutViewConstraint {

    var left: LayoutConstraintItem {
        return LayoutConstraintItem(view: view, attribute: .left)
    }

    var right: LayoutConstraintItem {
        return LayoutConstraintItem(view: view, attribute: .right)
    }

    var top: LayoutConstraintItem {
        return LayoutConstraintItem(view: view, attribute: .top)
    }

    var bottom: LayoutConstraintItem {
        return LayoutConstraintItem(view: view, attribute: .bottom)
    }

    var width: LayoutConstraintItem {
        return LayoutConstraintItem(view: view, attribute: .width)
    }

    var height: LayoutConstraintItem {
        return LayoutConstraintItem(view: view, attribute: .height)
    }

    var centerX: LayoutConstraintItem {
        return LayoutConstraintItem(view: view, attribute: .centerX)
    }

    var centerY: LayoutConstraintItem {
        return LayoutConstraintItem(view: view, attribute: .centerY)
    }

    var leading: LayoutConstraintItem {
        return LayoutConstraintItem(view: view, attribute: .leading)
    }

    var trailing: LayoutConstraintItem {
        return LayoutConstraintItem(view: view, attribute: .trailing)
    }

    var safeArea: LayoutViewConstraintSafeArea {
        return LayoutViewConstraintSafeArea(view: view)
    }

}
