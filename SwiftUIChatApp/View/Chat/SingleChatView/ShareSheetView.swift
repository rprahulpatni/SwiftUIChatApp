//
//  ShareSheetView.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 22/08/23.
//

import SwiftUI

struct ShareSheetView: View {
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 20){
                Button(action: {
                    
                }, label: {
                    Label("Picture", systemImage: StringConstants.placeholderImagePicture)
                        .foregroundColor(.teal)
                })
                Button(action: {
                    
                }, label: {
                    Label("Picture", systemImage: StringConstants.placeholderImagePicture)
                        .foregroundColor(.teal)
                })
                Button(action: {
                    
                }, label: {
                    Label("Picture", systemImage: StringConstants.placeholderImagePicture)
                        .foregroundColor(.teal)
                })
                Button(action: {
                    
                }, label: {
                    Label("Picture", systemImage: StringConstants.placeholderImagePicture)
                        .foregroundColor(.teal)
                })
            }
            .padding(.all, 20)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}

struct ShareSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ShareSheetView()
    }
}
