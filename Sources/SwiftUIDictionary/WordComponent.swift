//
//  WordComponent.swift
//  SwiftUIDictionary
//

import SwiftUI

// Data structure for representing a String and a possible Definition attached to it.
internal struct WordComponent: Identifiable {
    public let base: String, definition: Definition?
    public let id = UUID()
    
    public init(base: String, value: String) {
        self.base = base
        self.definition = Definition(word: base, value: value)
    }
    
    public init(base: String, value: Definition? = nil) {
        self.base = base
        self.definition = value
    }
}

extension WordComponent: CustomStringConvertible {
    public var description: String {
        definition?.description ?? base
    }
}

extension WordComponent: Equatable {
    public static func == (lhs: WordComponent, rhs: WordComponent) -> Bool {
        lhs.id == rhs.id
    }
}
