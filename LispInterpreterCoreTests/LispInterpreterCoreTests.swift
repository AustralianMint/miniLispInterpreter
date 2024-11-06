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
    
    func testEmptyList() throws {
        let input = "()"
        let tokens = Parser.tokenize(input)
        let (parsed, _) = try Parser.parse(tokens)
        let result = try interpreter.evaluate(parsed)
        
        XCTAssertEqual(result, .null, "Empty list should evaluate to null")
    }
    
    // MARK: Arithmetic Tests
    
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

    func testAdditionWithNoArgs() throws {
        let input = "(+)"
        let tokens = Parser.tokenize(input)
        let (parsed, _) = try Parser.parse(tokens)
        let result = try interpreter.evaluate(parsed)
        
        guard case .number(let value) = result else {
            XCTFail("Expected .number, got \(result)")
            return
        }
        XCTAssertEqual(value, 0, "Addition with no args should return 0")
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
    
    func testSubtractionWithNoArgs() throws {
        let input = "(-)"
        let tokens = Parser.tokenize(input)
        let (parsed, _) = try Parser.parse(tokens)
        
        XCTAssertThrowsError(try interpreter.evaluate(parsed)) { error in
            guard case let LispError.typeError(message) = error else {
                XCTFail("Expected typeError, got \(error)")
                return
            }
            XCTAssertTrue(message.contains("Expected at least one argument"))
        }
    }
}
