//
//  CustomLoaderModifier.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 17/07/23.
//

import SwiftUI

struct CustomLoaderModifier: ViewModifier {
    @Binding var isLoading: Bool
    func body(content: Content) -> some View {
        ZStack {
            content
            if isLoading {
                // Blur view
                VisualEffectView(effect: UIBlurEffect(style: .regular))
                    .edgesIgnoringSafeArea(.all)
                CustomProgressView(showProgress: $isLoading)
            }
        }
    }
}

extension View {
    func loader(isLoading: Binding<Bool>) -> some View {
        self.modifier(CustomLoaderModifier(isLoading: isLoading))
    }
}

// Helper view for applying the blur effect
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}
