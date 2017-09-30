//MIT License
//
//Copyright (c) 2017 Manny Guerrero
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

import XCTest
@testable import SwiftyBind

/// Test suite for testing SwiftyBind behavior.
final class SwiftyBindTests: XCTestCase {
    
    // MARK: - Public Class Attributes
    static var allTests = [
        ("testBind", testBind),
    ]
    
    
    // MARK: - Tests
    
    /// Tests the binding behavior of SwiftyBind.
    func testBind() {
        let swiftyBind = SwiftyBind("Bob Saget")
        let bindExpectation = expectation(description: "Test bind behavior expectation")
        swiftyBind.interface.bind {
            XCTAssertEqual("Uncle Jesse", $0, "Value did not change!")
            bindExpectation.fulfill()
        }
        swiftyBind.value = "Uncle Jesse"
        waitForExpectations(timeout: 10) { (error) in
            guard error == nil else {
                XCTFail("Error occured in expectation!")
                return
            }
        }
    }
    
    /// Tests the bind and firing behavior of SwiftyBind.
    func testBindAndFire() {
        let swiftyBind = SwiftyBind("Bob Saget")
        let bindAndFireExpectation = expectation(description: "Test bind and fire behavior expectation")
        swiftyBind.interface.bindAndFire {
            XCTAssertEqual("Bob Saget", $0, "Value did not change!")
            bindAndFireExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            guard error == nil else {
                XCTFail("Error occured in expectation!")
                return
            }
        }
    }
}
