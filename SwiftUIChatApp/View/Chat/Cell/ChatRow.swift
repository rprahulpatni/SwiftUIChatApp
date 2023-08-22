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
                        Text(item.text ?? "")
                            .modifier(chatModifier(myMessage: true))
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
                        Text(item.text ?? "")
                            .modifier(chatModifier(myMessage: false))
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
