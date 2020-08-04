//
//  DictionaryView.swift
//  SwiftUIDictionary
//

import SwiftUI

public struct DictionaryView: View {
    // Text Definition Component Map
    private let map: DefinitionMap
    
    public init(_ verbatim: String, vocab: [Definition]) {
        self.map = verbatim.map(vocab: vocab)
    }
    
    // Content Size
    @State private var size: CGSize? = nil
    
    public var body: some View {
        GeometryReader { proxy in
            self.content(proxy: proxy)
                // Purpose: Adjusting parent size
                .background(self.read(size: self.$size))
        }
        // Adjust size dependent on content size.
        // Note: Previews do not show proper view size until
        // program has been on runtime (where the alignment is computed).
        .frame(width: size?.width, height: size?.height)
    }
    
    private func read(size: Binding<CGSize?>) -> some View {
        GeometryReader { proxy -> Color in
            let frame = proxy.frame(in: .local)
            
            DispatchQueue.main.async {
                size.wrappedValue = frame.size
            }
            
            return .clear
        }
    }
    
    private func content(proxy: GeometryProxy) -> some View {
        
        var width: CGFloat = .zero, height: CGFloat = .zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(map) { component in
                TextCellView(component: component)
                    .padding(.horizontal, 3)
                    .alignmentGuide(.leading, computeValue: { context in
                        
                        if (abs(width - context.width) > proxy.size.width) {
                            width = 0
                            height -= context.height
                        }
                        
                        let result = width
                        
                        if component == self.map.last! {
                            width = 0
                        } else {
                            width -= context.width
                        }
                        
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        
                        if component == self.map.last! {
                            height = 0
                        }
                        
                        return result
                    })
            }
        }
    }
}

// Created by Peter Larson
