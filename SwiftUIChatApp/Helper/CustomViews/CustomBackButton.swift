//
//  CustomBackButton.swift
//  ListAndNavDemo
//
//  Created by Neosoft on 26/05/23.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.backward").font(.title2)
        }
    }
}

struct CustomBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButton()
    }
}

struct CustomPopToRootButton: View {
    var body: some View {
        Button {
            NavigationUtil.popToRootView()
        } label: {
            Image(systemName: "chevron.backward").font(.title2)
        }
    }
}

struct CustomPopToRootButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomPopToRootButton()
    }
}
