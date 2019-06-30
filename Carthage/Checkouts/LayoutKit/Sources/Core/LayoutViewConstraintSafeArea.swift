//
//  LayoutViewConstraintSafeArea.swift
//  LayoutKit
//
//  Created by Vinicius França on 29/09/18.
//  Copyright © 2018 Vinicius França. All rights reserved.
//

import Foundation

public class LayoutViewConstraintSafeArea {

    internal let view: LayoutView

    internal required init(view: LayoutView) {
        self.view = view
    }

}

public extension LayoutViewConstraintSafeArea {

    var left: LayoutConstraintSafeAreaItem {
        return LayoutConstraintSafeAreaItem(view: view, attribute: .left)
    }

    var right: LayoutConstraintSafeAreaItem {
        return LayoutConstraintSafeAreaItem(view: view, attribute: .right)
    }

    var top: LayoutConstraintSafeAreaItem {
        return LayoutConstraintSafeAreaItem(view: view, attribute: .top)
    }

    var bottom: LayoutConstraintSafeAreaItem {
        return LayoutConstraintSafeAreaItem(view: view, attribute: .bottom)
    }

    var width: LayoutConstraintSafeAreaItem {
        return LayoutConstraintSafeAreaItem(view: view, attribute: .width)
    }

    var height: LayoutConstraintSafeAreaItem {
        return LayoutConstraintSafeAreaItem(view: view, attribute: .height)
    }

    var centerX: LayoutConstraintSafeAreaItem {
        return LayoutConstraintSafeAreaItem(view: view, attribute: .centerX)
    }

    var centerY: LayoutConstraintSafeAreaItem {
        return LayoutConstraintSafeAreaItem(view: view, attribute: .centerY)
    }

    var leading: LayoutConstraintSafeAreaItem {
        return LayoutConstraintSafeAreaItem(view: view, attribute: .leading)
    }

    var trailing: LayoutConstraintSafeAreaItem {
        return LayoutConstraintSafeAreaItem(view: view, attribute: .trailing)
    }
}
