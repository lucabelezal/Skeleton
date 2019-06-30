# LayoutKit

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/LayoutKit.svg)](https://cocoapods.org/pods/LayoutKit)
[![Travis](https://img.shields.io/travis/viniciusfranca/LayoutKit/master.svg)](https://travis-ci.org/viniciusfranca/LayoutKit/branches)

LayoutKit is a DSL to make Auto Layout easy iOS

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Requirements

- iOS 9.0+
- Xcode 10.0+
- Swift 4.2+

## Installation

### CocoaPods - Coming Soon 😔

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate LayoutKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'LayoutKit', '~> 1.0.0'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate LayoutKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "viniciusfranca/LayoutKit" ~> 1.0.0
```

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate LayoutKit into your project manually.

<strong>Embedded Binaries</strong>

- Download the latest release from https://github.com/viniciusfranca/LayoutKit/releases
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- Add the downloaded `LayoutKit.framework`.
- And that's it!

## Usage

### Quick Start

```swift
import LayoutKit

class MyViewController: UIViewController {

    lazy var box = UIView()
    private var constraintReference: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /** addView method set box with 
          * translatesAutoresizingMaskIntoConstraints = false 
          * and addSubview
          */
        self.view.addView(box)

        box.layout.makeConstraints { make in
            make.top.equalTo(self.view.layout.top)
            // .reference() method guard reference constraint
            make.left.equalTo(self.view.layout.left).reference(&constraintReference)
            // .priority() method set priority in constraint
            make.right.equalTo(self.view.layout.right).priority(.medium)
            // .insetSafeArea() sum safeAreaInsets in constraint
            make.height.equalTo(constant: 100).insetSafeArea(.top)
        }

    }

}
```

## Contributing

Issues and pull requests are welcome :D

## License

LayoutKit is released under the MIT license. See [LICENSE](https://github.com/viniciusfranca/LayoutKit/blob/master/LICENSE) for details.
