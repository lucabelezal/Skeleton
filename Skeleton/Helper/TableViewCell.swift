//
//  TableViewCell.swift
//  Skeleton
//
//  Created by Lucas Nascimento on 31/08/19.
//  Copyright © 2019 Lucas Nascimento. All rights reserved.
//

import UIKit

public class TableViewCell<View: UIView, ViewModel>: UITableViewCell, Reusable where View: ViewModelOwner, View.ViewModel == ViewModel {

    public var customView: View

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
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
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // The final here is necessary and it's related to this https://developer.apple.com/swift/blog/?id=27
    public final var viewModel: ViewModel? {
        get {
            return customView.viewModel
        }

        set(newViewModel) {
            customView.viewModel = newViewModel
        }
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        customView.isSelected = selected
    }
}
