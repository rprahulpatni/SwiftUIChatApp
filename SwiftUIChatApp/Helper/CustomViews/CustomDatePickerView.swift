//
//  CustomDatePickerView.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 03/08/23.
//

import SwiftUI

struct CustomDatePickerView: View {
    @Binding var isPickerVisible: Bool
    @Binding var selectedDate: Date
    @Binding var selectedDateString: String

    var placeholder: String
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -100, to: Date())!
        let max = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        return min...max
    }
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.2)
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                HStack {
                    Button("Cancel") {
                        isPickerVisible = false
                    }
                    Spacer()
                    Text(DateFormatter.longDateFormatter.string(from: self.selectedDate))
                    Spacer()
                    Button("Done") {
                        isPickerVisible = false
                        selectedDateString = DateFormatter.longDateFormatter.string(from: self.selectedDate)
                    }
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .border(Color(UIColor.separator), width: 1)
                
                DatePicker("", selection: $selectedDate, in: dateClosedRange, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemBackground))
                    .hAlign(.center)
            }
            .onDisappear{
                hideKeyboard()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CustomDatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDatePickerView(isPickerVisible: .constant(true), selectedDate: .constant(Date()), selectedDateString: .constant("30-10-2022"), placeholder: "")
    }
}
