//
//  MovieListView.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 29/06/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import LayoutKit
import UIKit

public class MovieListView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieListView: ViewCodable {

    func configure() {
        
    }

    func hierarchy() {

    }

    func constraints() {

    }

    func styles() {

    }
}
