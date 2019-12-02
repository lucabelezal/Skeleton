//
//  ViewModelOwner.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 31/08/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import Foundation

protocol ViewModelOwner {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
    var isSelected: Bool { get set }
}
