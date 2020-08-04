struct Definition {
    let word: String, value: String
}

extension Definition: CustomStringConvertible {
    public var description: String {
        word + "=" + value
    }
}

struct ComponentPair {
    let component: String, definition: Definition?
    
    init(component: String, value: String) {
        self.component = component
        self.definition = Definition(word: component, value: value)
    }
    
    init(component: String, value: Definition? = nil) {
        self.component = component
        self.definition = value
    }
}

extension ComponentPair: CustomStringConvertible {
    var description: String {
        definition?.description ?? component
    }
}

internal typealias DefinitionMap = [ComponentPair]

import Foundation

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
        .reduce(into: [ComponentPair]()) { (endResult, components) in
            components.forEach { (component) in
                let definition = vocab.first { (definition) -> Bool in
                    definition.word == component
                }
                
                endResult.append(ComponentPair(component: component, value: definition))
            }
        }
    }
}

// Given input
let input = "SwiftUI is awesome!"
// Expected output
let vocab = [Definition(word: "SwiftUI", value: "Apple's UI Framework")]
let expected = [
    ComponentPair(component: "SwiftUI", value: "Apple's UI Framework"),
    ComponentPair(component: "is", value: nil),
    ComponentPair(component: "awesome!", value: nil)
]

print(input.map(vocab: vocab))
