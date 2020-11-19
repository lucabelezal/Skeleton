import Foundation

protocol ViewModelOwner {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
    var isSelected: Bool { get set }
}
