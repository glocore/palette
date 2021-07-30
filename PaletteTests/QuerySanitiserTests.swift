//
//  QuerySanitiserTests.swift
//  PaletteTests
//
//  Created by Ashwin on 30/07/21.
//

import XCTest
@testable import Palette

class QuerySanitiserTests: XCTestCase {
    var querySanitiser: QuerySanitiser!
    
    override func setUp() {
        querySanitiser = QuerySanitiser()
    }
    
    override func tearDown() {
        querySanitiser = nil
    }
    
    func test_leading_and_trailing_spaces() {
        XCTAssertEqual(querySanitiser.sanitise(" test string "), "test string")
    }
}
