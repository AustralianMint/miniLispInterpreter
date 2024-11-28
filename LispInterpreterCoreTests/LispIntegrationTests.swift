//
//  LispIntegrationTests.swift
//  miniLispInterpreter
//
//  Created by Thomas Frey on 28.11.24.
//

import XCTest
@testable import LispInterpreterCore

final class LispIntegrationTests: XCTestCase {
    
    var interpreter: Interpreter!
    
    override func setUp() {
        super.setUp()
        interpreter = Interpreter()
    }
    
    // Helper function to parse and evaluate expressions
    private func evaluate(_ expression: String) throws -> LispValue {
        let tokens = Parser.tokenize(expression)
        let (parsed, remaining) = try Parser.parse(tokens)
        XCTAssertTrue(remaining.isEmpty, "Parser should consume all tokens")
        return try interpreter.evaluate(parsed)
    }
    
    func testBasicArithmetic() throws {
        // test addition
        XCTAssertEqual(try evaluate("(+ 1 2)"), .number(3))
        XCTAssertEqual(try evaluate("(+ 1 2 3 4)"), .number(10))
        XCTAssertEqual(try evaluate("(+ -1 1)"), .number(0))
        XCTAssertEqual(try evaluate("(+)"), .number(0))  // Empty sum should return 0
        
        // test subtratction
        XCTAssertEqual(try evaluate("(- 5 3)"), .number(2))
        XCTAssertEqual(try evaluate("(- 10 2 3)"), .number(5))
        XCTAssertEqual(try evaluate("(- 5)"), .number(5))  // Single argument
    }
    
    func testNestedExpressions() throws {
        XCTAssertEqual(try evaluate("(+ 1 (+ 2 3))"), .number(6))
        XCTAssertEqual(try evaluate("(- 10 (+ 2 3))"), .number(5))
        XCTAssertEqual(try evaluate("(+ (- 5 3) (+ 1 2))"), .number(5))
    }
    
    func testErrorHandling() throws {
        // Invalid syntax
        XCTAssertThrowsError(try evaluate("(")) { error in
            XCTAssertTrue(error is LispError)
            if case let LispError.syntaxError(message) = error {
                XCTAssertTrue(message.contains("Missing closing parenthesis"))
            }
        }
    }
}

