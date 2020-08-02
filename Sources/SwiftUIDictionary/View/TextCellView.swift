//
//  File.swift
//  
//
//  Created by Peter Larson on 8/2/20.
//

import SwiftUI

struct TextCellView: View {
    /// Model
    private let pair: WordPair
    /// State
    @State private var isPressing = false
    @State private var isShowing = false
    @State private var height: CGFloat = 0
    @State private var subHeight: CGFloat = 0
    /// Initializer
    public init(pair: WordPair) {
        self.pair = pair
    }
    /// Overlay subview
    var overlay: some View {
        if let definition = pair.definition {
            return AnyView(
                definition.body
                    .background(height($subHeight))
                    .scaleEffect(isShowing ? 1 : 0, anchor: .bottom)
                    .offset(y: -subHeight / 2)
                    .padding(.bottom, height)
                    .opacity(isShowing ? 1 : 0)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .frame(maxHeight: .infinity)
                    .fixedSize()
            )
        } else {
            return AnyView(EmptyView())
        }
    }
    /// Body
    var body: some View {
        Text(pair.string)
            .underline(pair.definition != nil, color: Color.black)
            .background(height($height))
            .overlay(overlay)
            .onTapGesture {
                withAnimation(.spring()) {
                    self.isShowing.toggle()
                }
            }
    }
    /// Height-getter
    private func height(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
