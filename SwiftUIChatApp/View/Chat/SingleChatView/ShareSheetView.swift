//
//  ShareSheetView.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 22/08/23.
//

import SwiftUI

struct ShareSheetView: View {
    @Binding var selectedMsgType: MessageType
    @Binding var isShareSheetVisible: Bool
    @Binding var isImagePickerPresented: Bool

    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.selectedMsgType = .picture
                    self.isImagePickerPresented = true
                    self.isShareSheetVisible = false
                }, label: {
                    VStack{
                        Image(systemName: StringConstants.placeholderImagePicture)
                            .font(.title)
                            .padding(20)
                            .foregroundColor(.white)
                            .background(.teal)
                            .clipShape(Circle())
                        Text("Picture")
                            .foregroundColor(.teal)
                    }
                })
                Spacer()
                Button(action: {
                    self.selectedMsgType = .video
                    self.isShareSheetVisible = false
                }, label: {
                    VStack{
                        Image(systemName: StringConstants.placeholderImageVideo)
                            .font(.title)
                            .padding(20)
                            .foregroundColor(.white)
                            .background(.teal)
                            .clipShape(Circle())
                        Text("Video")
                            .foregroundColor(.teal)
                    }
                })
                Spacer()
                Button(action: {
                    self.selectedMsgType = .location
                    self.isShareSheetVisible = false
                }, label: {
                    VStack{
                        Image(systemName: StringConstants.placeholderImageLocation)
                            .font(.title)
                            .padding(20)
                            .foregroundColor(.white)
                            .background(.teal)
                            .clipShape(Circle())
                        Text("Location")
                            .foregroundColor(.teal)
                    }
                })
            }
            .padding(.all, 25)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        //            .background(.white)
        //            .cornerRadius(10)
        //            .shadow(radius: 5)
        //            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}

struct ShareSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ShareSheetView(selectedMsgType: .constant(.picture), isShareSheetVisible: .constant(false), isImagePickerPresented: .constant(false))
    }
}
