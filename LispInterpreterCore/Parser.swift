//
//  Parser.swift
//  miniLispInterpreter
//
//  Created by Thomas Frey on 04.11.24.

// Takes the input and transform into something the computer understands.

class Parser {
    static func tokenize(_ input: String) -> [String] {
        let input = input.replacingOccurrences(of: "(", with: " ( ")
            .replacingOccurrences(of: ")", with: " ) ")
        return input.split(separator: " ")
            .map(String.init)
            .filter { !$0.isEmpty}
    }
    
    static func parse(_ tokens: [String]) throws -> (LispValue, [String]) {
        guard let token = tokens.first else {
            throw LispError.syntaxError("Unexpected EOF")
        }
        
        let remaining = Array(tokens.dropFirst())
        
        if token == "(" {
            var list: [LispValue] = []
            var currentTokens = remaining
            
            while !currentTokens.isEmpty && currentTokens[0] != ")" {
                let (value, remainingTokens) = try parse(currentTokens)
                list.append(value)
                currentTokens = remainingTokens
            }
            
            if currentTokens.isEmpty {
                throw LispError.syntaxError("Missing closing parenthesis")
            }
            
            return (.list(list), Array(currentTokens.dropFirst()))
        } else if token == ")" {
            throw LispError.syntaxError("Unexpected closing parenthesis")
        } else if let number = Double(token) {
            return (.number(number), remaining)
        } else {
            return (.symbol(token), remaining) 
        }
    }
}
