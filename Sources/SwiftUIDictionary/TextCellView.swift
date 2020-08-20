////
//
//  TextCellView.swift
//  SwiftUIDictionary
//

import SwiftUI

// View representation of a WordComponent Model
internal struct TextCellView: View {
    // Model
    private let component: WordComponent
    // State
    @State private var isPressing = false
    @State private var isShowing = false
    @State private var height: CGFloat = 0
    @State private var subHeight: CGFloat = 0
    // Initializer
    public init(component: WordComponent) {
        self.component = component
        
    }
    // Overlay
    var overlay: some View {
        component.definition?.body
            .background(height($subHeight))
            .scaleEffect(isShowing ? 1 : 0, anchor: .bottom)
            .offset(y: -subHeight / 2)
            .padding(.bottom, height)
            .opacity(isShowing ? 1 : 0)
//            .frame(width: UIScreen.main.bounds.width / 2)
            .frame(maxHeight: .infinity)
            .fixedSize()
    }
    // Body
    public var body: some View {
        Text(component.base)
            .underline(component.definition != nil, color: Color.black)
            .fixedSize()
            .background(height($height))
            .overlay(overlay)
            .onTapGesture {
                withAnimation(Animation.spring().speed(2.0)) {
                    self.isShowing.toggle()
                }
            }
        
    }
    // Height-getter
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
