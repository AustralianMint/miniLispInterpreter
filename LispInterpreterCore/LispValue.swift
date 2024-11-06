//
//  LispValue.swift
//  miniLispInterpreter
//
//  Created by Thomas Frey on 04.11.24.

// Needed to specify which values the interpreter understands

public enum LispValue {
    case symbol(String)
    case number(Double)
    case list([LispValue])
    case function((([LispValue]) throws -> LispValue))
    case null
}
