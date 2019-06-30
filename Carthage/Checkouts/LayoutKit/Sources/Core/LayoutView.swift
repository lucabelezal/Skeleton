//
//  LayoutView.swift
//  LayoutKit
//
//  Created by Vinicius França on 29/09/18.
//  Copyright © 2018 Vinicius França. All rights reserved.
//

import UIKit

public extension LayoutView {

    var layout: LayoutViewConstraint {
        return LayoutViewConstraint(view: self)
    }

    @available(*, deprecated)
    func add(_ subviews: UIView...) {
        subviews.forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func addView(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }

}
