//
//  LispValue.swift
//  miniLispInterpreter
//
//  Created by Thomas Frey on 04.11.24.

// Needed to specify which values the interpreter understands

public enum LispValue: Equatable {
    case symbol(String)
    case number(Double)
    case list([LispValue])
    case function((([LispValue]) throws -> LispValue))
    case null
    
    // Needed to conform to the enum's Equatable protocol
    // Will define how two values will be compared for equality
    public static func == (lhs: LispValue, rhs: LispValue) -> Bool {
        switch (lhs, rhs) {
        case (.number(let l), .number(let r)):
            return l == r
        case (.symbol(let l), .symbol(let r)):
            return l == r
        case (.list(let l), .list(let r)):
            return l == r
        case (.null, .null):
            return true
        case (.function, .function):
            return false
        default:
            return false
        }
    }
}
