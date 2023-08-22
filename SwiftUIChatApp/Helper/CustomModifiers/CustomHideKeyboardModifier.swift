//
//  CustomHideKeyboardModifier.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 18/07/23.
//

import SwiftUI

struct CustomHideKeyboardModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            content
                .onTapGesture {
                    hideKeyboard()
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard, content: {
                        Spacer()
                        Button(action: {
                            hideKeyboard()
                        }, label: {
                            Text("Done").foregroundColor(.blue)
                        })
                    })
                }
        }
    }
}

extension View {
    func hideKeyboardModifier() -> some View {
        self.modifier(CustomHideKeyboardModifier())
    }
}

