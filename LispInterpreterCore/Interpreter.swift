//
//  Interpreter.swift
//  miniLispInterpreter
//
//  Created by Thomas Frey on 04.11.24.

// The brain that actually does the calculations

public class Interpreter {
    var environment: [String: LispValue] = [:]
    
    init () {
        setupDefaultEnvironment()
    }
    
    private func setupDefaultEnvironment () {
        
        // Basic arithmetic operations
        environment["+"] = .function { args in
            let numbers = try args.map { value in
                guard case .number(let n) = value else {
                    throw LispError.typeError("Expected number but got \(value)")
                }
                return n
            }
            return .number(numbers.reduce(0, +))
        }
        
        environment["-"] = .function { args in
            guard !args.isEmpty else { throw LispError.typeError("Expected at least one argument")}
            let numbers = try args.map { value in
                guard case .number(let n) = value else {
                    throw LispError.typeError("Expected number but got \(value)")
                }
                return n
            }
            return .number(numbers[1...].reduce(numbers[0], -))
        }
    }
    
    func evaluate (_ expression: LispValue) throws -> LispValue {
        switch expression {
        case .number:
            return expression
            
        case .symbol(let name):
            guard let value = environment[name] else {
                throw LispError.nameError("Unknown symbol \(name)")
            }
            return value
            
        case .list(let list):
            guard !list.isEmpty else { return .null }
            
            let first = try evaluate(list[0])
            guard case .function(let function) = first else {
                throw LispError.typeError("Expected function but got \(first)")
            }
            
            let args = Array(list.dropFirst())
            let evaluatedArgs = try args.map { try evaluate($0) }
            return try function(evaluatedArgs)
            
        case .function, .null:
            return expression
        }
    }
}
