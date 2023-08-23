//
//  ChatRow.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 22/08/23.
//

import SwiftUI

struct ChatRow: View {
    var item: MessageModel
    var uid : String
    
    var body: some View {
        VStack{
            if item.senderId == uid {
                HStack{
                    Spacer()
                    VStack(alignment: .trailing){
                        switch item.msgType {
                        case .text:
                            Text(item.text ?? "")
                                .modifier(chatModifier(myMessage: true))
                        case .picture:
                            let imgUrl = URL(string: item.uploadedURL ?? "")
                            CustomSDWebImageView(imgURL: imgUrl, imgWidth: 200, imgHeight: 200, placeholderImage: StringConstants.placeholderImagePerson, isCircle: false)
                        case .video:
                            let imgUrl = URL(string: item.uploadedURL ?? "")
                            CustomSDWebImageView(imgURL: imgUrl, imgWidth: 200, imgHeight: 200, placeholderImage: StringConstants.placeholderImagePerson, isCircle: false)
                        case .location:
                            Text("Location")
                        case .none:
                            Text("Location")
                        }
                        Text(DateFormatter.timeStampToDate(timeVal: item.timestamp ?? "", dateFormat: "hh:mm a"))
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding(.trailing, 10)
                    }
                }
                .padding(.horizontal)
            } else {
                HStack{
                    VStack(alignment: .leading){
                        switch item.msgType {
                        case .text:
                            Text(item.text ?? "")
                                .modifier(chatModifier(myMessage: false))
                        case .picture:
                            let imgUrl = URL(string: item.uploadedURL ?? "")
                            CustomSDWebImageView(imgURL: imgUrl, imgWidth: 200, imgHeight: 200, placeholderImage: StringConstants.placeholderImagePerson, isCircle: false)
                        case .video:
                            let imgUrl = URL(string: item.uploadedURL ?? "")
                            CustomSDWebImageView(imgURL: imgUrl, imgWidth: 200, imgHeight: 200, placeholderImage: StringConstants.placeholderImagePerson, isCircle: false)
                        case .location:
                            Text("Location")
                        case .none:
                            Text("Location")
                        }
                        Text(DateFormatter.timeStampToDate(timeVal: item.timestamp ?? "", dateFormat: "hh:mm a"))
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding(.leading, 10)
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(item: MessageModel(receiverId: "456", senderId: "123", text: "Hello, test msg",  timestamp: "1692623914719"), uid: "")
    }
}

struct chatModifier : ViewModifier{
    var myMessage : Bool
    func body(content: Content) -> some View {
        content
            .padding()
            .background(myMessage ? Color.teal : Color.gray)
            .cornerRadius(20)
            .foregroundColor(Color.white)
    }
}
