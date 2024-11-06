//
//  LispParserCoreTests.swift
//  LispInterpreterCoreTests
//
//  Created by Thomas Frey on 05.11.24.
//

import XCTest
@testable import LispInterpreterCore

final class LispParserCoreTests: XCTestCase {
    var parser: Parser!
    
    override func setUp() {
        super.setUp()
        parser = Parser()
    }
    
    func testParserCreation() {
        let parser = Parser()
        XCTAssertNotNil(parser)
    }
    
    func testParserTokenize() {
        let result = Parser.tokenize("(+ 1 2 3)")
        XCTAssertEqual(result, ["(", "+" ,"1", "2", "3", ")"])
    }
}
