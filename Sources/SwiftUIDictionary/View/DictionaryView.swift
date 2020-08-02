//
//  DictionaryView.swift
//
//  Created by Peter Larson on 8/2/20.
//

import SwiftUI

public struct DictionaryView: View {
    
    /// MARK: State
    @State private var totalHeight: CGFloat = 0
    
    private let map: DefinitionMap
    
    public init(_ text: String, definitions: [WordDefinition]) {
        self.map = text.map(definitions: definitions)
    }
    
    public var body: some View {
        VStack {
            GeometryReader { proxy in
                self.content(in: proxy)
            }
        }
        .frame(maxHeight: totalHeight)
    }
    
    fileprivate func content(in proxy: GeometryProxy) -> some View {
        var width = CGFloat.zero, height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.map, id: \.self) { pair in
                TextCellView(pair: pair)
                    .alignmentGuide(.leading, computeValue: { context in
                        if (abs(width - context.width) > proxy.size.width) {
                            width = 0
                            height -= context.height
                        }
                        let result = width
                        if pair == self.map.last! {
                            width = 0
                        } else {
                            width -= context.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if pair == self.map.last! {
                            height = 0
                        }
                        return result
                    })
            }
        }.background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
