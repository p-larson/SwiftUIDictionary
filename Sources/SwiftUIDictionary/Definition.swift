//
//  Definition.swift
//  SwiftUIDictionary
//

import SwiftUI

public struct Definition {
    public let word: String, value: String
    
    public init(word: String, value: String) {
        self.word = word
        self.value = value
    }
}

extension Definition: CustomStringConvertible {
    public var description: String {
        word + "=" + value
    }
}

extension Definition {
    var body: some View {
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
