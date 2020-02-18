//
//  TableViewCell.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 31/08/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

class TableViewCell<View: UIView, ViewModel>: UITableViewCell, Reusable where View: ViewModelOwner, View.ViewModel == ViewModel {

    var customView: View

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        customView = View()

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(customView)

        customView.setContentHuggingPriority(.required, for: .vertical)
        customView.setContentCompressionResistancePriority(.required, for: .vertical)

        customView.translatesAutoresizingMaskIntoConstraints = false

        customView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        customView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    final var viewModel: ViewModel? {
        get {
            return customView.viewModel
        }

        set(newViewModel) {
            customView.viewModel = newViewModel
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        customView.isSelected = selected
    }
    
}
