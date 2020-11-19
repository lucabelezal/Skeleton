import UIKit

protocol ViewCodable {
    func setupView()
    func configure()
    func hierarchy()
    func constraints()
    func styles()
    func bindComponents()
    func setupAcessibilityIdentifiers()
}

extension ViewCodable {

    func setupView() {
        configure()
        hierarchy()
        constraints()
        styles()
        bindComponents()
        setupAcessibilityIdentifiers()
    }

    func configure() {}
    
    func bindComponents() { }

    func setupAcessibilityIdentifiers() { }
}
