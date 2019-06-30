//
//  LayoutViewSpec.swift
//  LayoutKitTests-iOS
//
//  Created by Vinicius França on 01/10/18.
//  Copyright © 2018 viniciusfranca. All rights reserved.
//

import Quick
import Nimble
@testable import LayoutKit

class LayoutViewSpec: QuickSpec {
    
    override func spec() {
        
        describe("LayoutView") {
            
            context("when initialize view", closure: {
                
                var contentSampleView: UIView!
                var contentSubView: UIView!
                
                beforeEach {
                    contentSampleView = UIView()
                    contentSubView = UIView()
                }
                
                context("when call var layout", closure: {
                    
                    var layoutViewConstraint: LayoutViewConstraint!
                    
                    beforeEach {
                        layoutViewConstraint = contentSubView.layout
                    }
                    
                    it("should return view", closure: {
                        expect(layoutViewConstraint.view).to(equal(contentSubView))
                    })
                    
                })
                
                context("when call method add for add sub view", closure: {
                    
                    beforeEach {
                        contentSampleView.add(contentSubView)
                    }
                    
                    it("should contains contentSubView", closure: {
                        expect(contentSampleView.subviews.contains(contentSubView)).to(beTrue())
                    })
                    
                    it("should return view with translate auto resizing false", closure: {
                        expect(contentSampleView.subviews[0].translatesAutoresizingMaskIntoConstraints).to(beFalse())
                    })
                    
                })
                
                context("when call method add for addView sub view", closure: {
                    
                    beforeEach {
                        contentSampleView.addView(contentSubView)
                    }
                    
                    it("should contains contentSubView", closure: {
                        expect(contentSampleView.subviews.contains(contentSubView)).to(beTrue())
                    })
                    
                    it("should return view with translate auto resizing false", closure: {
                        expect(contentSampleView.subviews[0].translatesAutoresizingMaskIntoConstraints).to(beFalse())
                    })
                    
                })
                
            })
            
        }
        
    }
    
}

