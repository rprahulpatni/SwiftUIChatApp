//
//  CustomCountryPickerView.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 11/07/23.
//

import SwiftUI

struct CustomCountryPickerView: View {
    var arrCountryList : [CountryList] = BundleDecoderFromJson.decodeCountryListFromBundleToJson()
    @State private var searchText = ""
    @State private var selectedText: String?
    @Binding var selectedCountryCode: String
    @Binding var isCountryPickerVisible: Bool

    var filteredItems : [CountryList] {
        if searchText.isEmpty {
            return arrCountryList
        } else {
            return arrCountryList.filter{ $0.name!.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(text: $searchText)
            List(filteredItems, id: \.self) { item in
                Button(action: {
                    selectedCountryCode = item.dial_code ?? ""
                    isCountryPickerVisible = false
                    hideKeyboard()
                }, label: {
                    HStack {
                        Text(item.flag!)
                        Text(item.name!)
                        Spacer()
                        Text(item.dial_code!)
                    }
                })
            }.listStyle(.plain)
        } .onDisappear{
            hideKeyboard()
        }
    }
}

struct CustomCountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCountryPickerView(selectedCountryCode: .constant(""), isCountryPickerVisible: .constant(false))
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.all, 5)
            TextField("Search", text: $text)
                .padding(.vertical, 5)
                .frame(height: 40)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
        .padding(.all, 5)
        .background(Color(.systemGray6))
    }
}
