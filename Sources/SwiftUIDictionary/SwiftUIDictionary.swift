// SwiftUIDictionary – Peter Larson

import Foundation
import SwiftUI

internal func seperate(vocab: [String], from input: String, caseSensitive: Bool = false) -> [String] {
    vocab.reduce(into: [input]) { (result, split) in
        result = result.reduce(into: [String]()) { (compound, string) in
            let components = (caseSensitive ? string : string.lowercased())
                .components(separatedBy: (caseSensitive ? split : split.lowercased()))
            
            let mirror = mirrorSplit(input: string, from: components, skip: split.count)
            
            components.enumerated().forEach { (body) in
                if !body.element.isEmpty {
                    compound.append(caseSensitive ? body.element : mirror[body.offset])
                }

                if components.count - body.offset != 1 {
                    compound.append(split)
                }
            }
        }
    }
}

internal func mirrorSplit(input: String, from array: [String], skip: Int = 0) -> [String] {
    var index = input.startIndex
    
    return array.reduce([String]()) { (result, next) in
        let offsetIndex = input.index(index, offsetBy: next.count)
        
        var newResult = Array(result)
        
        newResult.append(String(input[index ..< offsetIndex]))
        
        index = input.index(offsetIndex, offsetBy: skip, limitedBy: input.endIndex) ?? input.startIndex
        
        return newResult
    }
}

public struct WordDefinition: Hashable {
    
    public let word: String, value: String
    
    public init(word: String, value: String) {
        self.word = word
        self.value = value
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(value)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .padding(4)
                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                
                
                .cornerRadius(4)
                .lineLimit(nil)
            Path {
                path in
                
                path.addLines(
                    [.init(x: 0, y: 0),
                     .init(x: 8, y: 0),
                     .init(x: 4, y: 8)]
                )
            }
            .fill(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
            .frame(width: 8, height: 8)
        }
    }
}

public struct WordPair: Identifiable {
    public let id = UUID()
    public let string: String
    public let definition: WordDefinition?
    
    public init(string: String, definition: WordDefinition? = nil) {
        self.string = string
        self.definition = definition
    }
}

extension WordPair: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(string)
        hasher.combine(definition)
    }
}

public typealias DefinitionMap = [WordPair]

public extension String {
    
    func map(definitions: [WordDefinition]) -> DefinitionMap {
        seperate(vocab: definitions.map { $0.word}, from: self, caseSensitive: false).map { string in
            
            if let definition = definitions.first(where: { (define) -> Bool in
                define.word == string
            }) {
                return WordPair(string: string, definition: definition)
            } else {
                return WordPair(string: string)
            }
        }
    }
}

// Peter Larson – July 30th, 2020
