//
//  main.swift
//  miniLispInterpreter
//
//  Created by Thomas Frey on 04.11.24.
//
import Foundation
import LispInterpreterCore

let interpreter = Interpreter()
let input = "()"

// Parsers breaks input into pieces
let tokens = Parser.tokenize(input)

// Parser organizes into a structure
let (parsed, _) = try Parser.parse(tokens)

// Interpreter calculates the result
let result = try interpreter.evaluate(parsed)
print(result)

