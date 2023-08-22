//
//  RectangleShadowView.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 07/06/23.
//

import SwiftUI

struct RectangleShadowView: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.all, 10)
    }
}

struct RectangleShadowView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleShadowView()
    }
}
