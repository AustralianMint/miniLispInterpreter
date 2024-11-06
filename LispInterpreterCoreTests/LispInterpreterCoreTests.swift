//
//  LispInterpreterCoreTests.swift
//  LispInterpreterCoreTests
//
//  Created by Thomas Frey on 05.11.24.
//

import XCTest
@testable import LispInterpreterCore

final class miniLispInterpreterTests: XCTestCase {
    var interpreter: Interpreter!
    
    override func setUp() {
        super.setUp()
        interpreter = Interpreter()
    }
    
    func testInterpreterCreation() {
        let interpreter = Interpreter()
        XCTAssertNotNil(interpreter)
    }
    
    func testAddition() throws {
        // Test basic addition
        let input = "(+ 1 2 3)"
        let tokens = Parser.tokenize(input)
        let (parsed, _) = try Parser.parse(tokens)
        let result = try interpreter.evaluate(parsed)
        
        guard case .number(let value) = result else {
            XCTFail("Expected .number, got \(result)")
            return
        }
        XCTAssertEqual(value, 6)
    }
    
    func testSubtraction() throws {
        // Test basic subtraction
        let input = "(- 1 2 3)"
        let tokens = Parser.tokenize(input)
        let (parsed, _) = try Parser.parse(tokens)
        let result = try interpreter.evaluate(parsed)
        
        guard case .number(let value) = result else {
            XCTFail("Expected .number, got \(result)")
            return
        }
        XCTAssertEqual(value, -4)
    }
}
