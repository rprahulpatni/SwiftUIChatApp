//
//  CustomPickerView.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 11/07/23.
//

import SwiftUI

struct CustomPickerView: View {
    @Binding var isPickerVisible: Bool
    @Binding var selectedOption: String
    var filteredItems: [String] = []
    var placeholder: String
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.2)
            VStack(spacing: 0) {
                Spacer()
                HStack {
                    Button("Cancel") {
                        isPickerVisible = false
                    }
                    Spacer()
                    Button("Done") {
                        isPickerVisible = false
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .border(Color(UIColor.separator), width: 1)
                
                Picker(selection: $selectedOption, label: Text("")) {
                    ForEach(self.filteredItems, id: \.self) { option in
                        Text(option)
                    }
                }
                .frame(height: 250)
                .background(Color(UIColor.systemBackground))
                .pickerStyle(WheelPickerStyle())
            }
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(.all)
    }
}

struct CustomPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomPickerView(isPickerVisible: .constant(false), selectedOption: .constant(""),filteredItems: ["+91 India", "+1 America"], placeholder: "+91")
    }
}
