//
//  CustomBtn.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 05/06/23.
//

import Foundation
import SwiftUI

struct CustomBtn: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .font(.title3)
            .fontWeight(.bold)
            .background(.teal, in: RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
    }
}

struct CustomGradientBtn: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            CustomGraditantView()
            configuration.label
                .padding()
                .frame(maxWidth: .infinity)
        }
    }
}
