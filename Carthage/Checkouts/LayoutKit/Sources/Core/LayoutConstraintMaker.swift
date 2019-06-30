//
//  LayoutConstraintMaker.swift
//  LayoutKit
//
//  Created by Vinicius França on 29/09/18.
//  Copyright © 2018 Vinicius França. All rights reserved.
//

import Foundation

public class LayoutConstraintMaker {

    internal let view: LayoutView

    internal required init(view: LayoutView) {
        self.view = view
    }

}

public extension LayoutConstraintMaker {

    var left: LayoutConstraintMakerExtendable {
        return LayoutConstraintMakerExtendable(view: view, attribute: .left)
    }

    var right: LayoutConstraintMakerExtendable {
        return LayoutConstraintMakerExtendable(view: view, attribute: .right)
    }

    var top: LayoutConstraintMakerExtendable {
        return LayoutConstraintMakerExtendable(view: view, attribute: .top)
    }

    var bottom: LayoutConstraintMakerExtendable {
        return LayoutConstraintMakerExtendable(view: view, attribute: .bottom)
    }

    var width: LayoutConstraintMakerExtendable {
        return LayoutConstraintMakerExtendable(view: view, attribute: .width)
    }

    var height: LayoutConstraintMakerExtendable {
        return LayoutConstraintMakerExtendable(view: view, attribute: .height)
    }

    var centerX: LayoutConstraintMakerExtendable {
        return LayoutConstraintMakerExtendable(view: view, attribute: .centerX)
    }

    var centerY: LayoutConstraintMakerExtendable {
        return LayoutConstraintMakerExtendable(view: view, attribute: .centerY)
    }

    var leading: LayoutConstraintMakerExtendable {
        return LayoutConstraintMakerExtendable(view: view, attribute: .leading)
    }

    var trailing: LayoutConstraintMakerExtendable {
        return LayoutConstraintMakerExtendable(view: view, attribute: .trailing)
    }

}
