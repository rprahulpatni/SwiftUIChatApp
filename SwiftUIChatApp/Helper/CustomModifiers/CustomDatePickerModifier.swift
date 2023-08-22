//
//  CustomDatePickerModifier.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 18/07/23.
//

import SwiftUI

//struct CustomDatePickerModifier_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomDatePickerModifier(selectedDate: .constant(Date()), isPresented:  .constant(true))
//    }
//}

struct CustomDatePickerModifier: ViewModifier {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                isPresented = true
            }
            .sheet(isPresented: $isPresented, content: {
                datePickerView
            })
    }
    
    private var datePickerView: some View {
        VStack {
            Spacer()
            
            DatePicker("Select a Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            Button(action: {
                isPresented = false
            }) {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }
            Spacer()
        }
    }
}
extension View {
    func datePickerSheet(selectedDate: Binding<Date>, isPresented: Binding<Bool>) -> some View {
        self.modifier(CustomDatePickerModifier(selectedDate: selectedDate, isPresented: isPresented))
    }
}
