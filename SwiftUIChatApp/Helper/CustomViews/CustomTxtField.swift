//
//  CustomTxtField.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 11/07/23.
//

import SwiftUI

struct CustomTxtField: View {
    var placeholderText: String
    @Binding var txt: String
    
    var body: some View {
        TextField(placeholderText, text: $txt)
            .textFieldStyle(CustomTxtFieldStyle())
    }
}

struct CustomTxtField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTxtField(placeholderText: "", txt: .constant(""))
    }
}
