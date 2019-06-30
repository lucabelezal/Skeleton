//
//  LayoutPriortizableSpec.swift
//  LayoutKit-iOS
//
//  Created by Bruno Fernandes on 10/9/18.
//  Copyright © 2018 viniciusfranca. All rights reserved.
//

import Quick
import Nimble
@testable import LayoutKit

class LayoutPriortizableSpec: QuickSpec {

    override func spec() {

        describe("LayoutPriortizableSpec") {

            it("priority low value") {

                let priority = LayoutPriortizable.low

                expect(priority.priorityValue.rawValue) == 250.0
            }

            it("priority medium value") {

                let priority = LayoutPriortizable.medium

                expect(priority.priorityValue.rawValue) == 500.0
            }

            it("priority hight value") {

                let priority = LayoutPriortizable.high

                expect(priority.priorityValue.rawValue) == 750.0
            }

            it("priority requerid value") {

                let priority = LayoutPriortizable.required

                expect(priority.priorityValue.rawValue) == 999.0
            }

            it("priority any value") {

                let priority = LayoutPriortizable.value(501.0)

                expect(priority.priorityValue.rawValue) == 501.0
            }

            context("in layout property", {

                let outview: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                let inview: UIView = UIView(frame: .zero)

                var constraint: NSLayoutConstraint!

                beforeEach {
                    outview.addView(inview)

                    inview.layout.makeConstraints({ make in
                        make.leading.equalTo(outview.layout.leading, constant: 10).priority(.high).reference(&constraint)
                        make.leading.equalTo(outview.layout.leading, constant: 20).priority(.value(751.0))
                        make.trailing.equalTo(outview.layout.trailing, constant: 20)
                        make.top.equalTo(outview.layout.top, constant: 20)
                        make.bottom.equalTo(outview.layout.bottom, constant: 20)
                    })

                    outview.layoutIfNeeded()
                }

                afterEach {
                    inview.removeFromSuperview()
                }

                it("priority leading is activate") {

                    let filter = outview.constraints.filter {
                        $0.firstAttribute == NSLayoutConstraint.Attribute.leading
                    }.sorted { $0.priority.rawValue < $1.priority.rawValue }


                    expect(filter.count) == 2
                    expect(filter.first!.priority.rawValue) == 750.0
                    expect(filter.last!.priority.rawValue) == 751.0
                }

                it("priority leading isn't activate") {

                    constraint.isActive = false

                    let filter = outview.constraints.filter {
                        $0.firstAttribute == NSLayoutConstraint.Attribute.leading
                    }.first!

                    expect(filter.priority.rawValue) == 751.0

                }

            })
        }
    }
}
