//
//  CustomTxtFieldStyle.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 06/06/23.
//

import Foundation
import SwiftUI

struct CustomTxtFieldStyle: TextFieldStyle {
    
    //    let systemImageString: String
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack{
            CustomGraditantView()
            HStack {
                configuration
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }.padding(.leading)
                .foregroundColor(.gray)
        }
    }
}

struct CustomGraditantView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(
                LinearGradient(
                    colors: [
                        .red,
                        .blue
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 50)
    }
}
