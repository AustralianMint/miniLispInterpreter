//
//  main.swift
//  miniLispInterpreter
//
//  Created by Thomas Frey on 04.11.24.
//
import Foundation

func evaluateExpression(_ input: String) {
    let interpreter = Interpreter()
    
    do {
        let tokens = Parser.tokenize(input)
        let (parsed, _) = try Parser.parse(tokens)
        let result = try interpreter.evaluate(parsed)
        print("Result: \(result)")
    } catch {
        print("Error: \(error)")
    }
}

evaluateExpression("(+ (- 4 2) 3)")
