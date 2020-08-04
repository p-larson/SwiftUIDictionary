// SwiftUIDictionary – Peter Larson
// All rights reserved, 2020.

import Foundation

internal typealias DefinitionMap = [WordComponent]

internal extension String {
    func map(vocab: [Definition]) -> DefinitionMap {
        // Seperate by whitespace
        self.components(separatedBy: .whitespaces)
        // Resplit by vocab
        .map { majorComponent in
            // String
            vocab.reduce(into: [majorComponent]) { (majorResult, definition) in
                majorResult = majorResult.reduce(into: [String](), { (minorResult, minorComponent) in
                    let minorComponents = minorComponent.components(separatedBy: definition.word)
                    
                    minorComponents.enumerated().forEach { (compound) in
                        if !compound.element.isEmpty {
                            minorResult.append(compound.element)
                        }

                        if minorComponents.count - compound.offset != 1 {
                            minorResult.append(definition.word)
                        }
                    }
                })
                
                // print(majorResult)
            }
        }
        // Compact
        .reduce(into: [WordComponent]()) { (endResult, components) in
            components.forEach { (component) in
                let definition = vocab.first { (definition) -> Bool in
                    definition.word == component
                }
                
                endResult.append(WordComponent(base: component, value: definition))
            }
        }
    }
}

// Peter Larson – July 30th, 2020
