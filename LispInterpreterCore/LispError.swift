//
//  LispError.swift
//  miniLispInterpreter
//
//  Created by Thomas Frey on 04.11.24.

// Handles things that can go wrong

public enum LispError: Error {
    case syntaxError(String)
    case typeError(String)
    case nameError(String)
    case argumentError(String)
}
