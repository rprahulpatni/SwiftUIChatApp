//
//  ChatRow.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 22/08/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatRow: View {
    var item: MessageModel
    var uid : String
    @State private var thumbnailImage: UIImage?
    
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
                            CustomSDWebImageView(imgURL: imgUrl, imgWidth: 250, imgHeight: 250, placeholderImage: StringConstants.placeholderImagePerson, isCircle: false, cornerRadius: 10)
                                .modifier(chatModifier(myMessage: true))
                        case .video:
                            WebImage(url: nil).placeholder{
                                ZStack(alignment: .center) {
                                    Image(uiImage: thumbnailImage ?? UIImage())
                                        .resizable()
                                        .frame(width: 250, height: 250)
                                        .cornerRadius(10)
                                        .modifier(chatModifier(myMessage: true))
                                        .onTapGesture {
                                            
                                        }
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 50, height: 50)
                                }
                            }
                        case .location:
                            CustomMapSnapShotView(lat: item.latitude ?? 0.0, long: item.longitude ?? 0.0)
                                .frame(width: 250, height: 250)
                                .cornerRadius(10)
                                .modifier(chatModifier(myMessage: true))
                            
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
                            CustomSDWebImageView(imgURL: imgUrl, imgWidth: 250, imgHeight: 250, placeholderImage: StringConstants.placeholderImagePerson, isCircle: false, cornerRadius: 10)
                                .modifier(chatModifier(myMessage: false))
                        case .video:
//                            let imgUrl = URL(string: item.uploadedURL ?? "")?.generateThumbnail()
                            WebImage(url: nil).placeholder{
                                ZStack(alignment: .center) {
                                    Image(uiImage: thumbnailImage ?? UIImage())
                                        .resizable()
                                        .frame(width: 250, height: 250)
                                        .cornerRadius(10)
                                        .modifier(chatModifier(myMessage: false))
                                        .onTapGesture {
                                            
                                        }
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 50, height: 50)
                                }
                            }
                        case .location:
                            CustomMapSnapShotView(lat: item.latitude ?? 0.0, long: item.longitude ?? 0.0)
                                .frame(width: 250, height: 250)
                                .cornerRadius(10)
                                .modifier(chatModifier(myMessage: false))
                            
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
        .onAppear{
            if let videoURL = URL(string: item.uploadedURL ?? "") {
                generateThumbnail(from: videoURL) { generatedImage in
                    if let generatedImage = generatedImage {
                        thumbnailImage = generatedImage
                    }
                }
            }
        }
    }
}

struct ChatRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatRow(item: MessageModel(receiverId: "456", senderId: "123", text: "",  timestamp: "1692623914719", msgType: .location, uploadedURL: "https://firebasestorage.googleapis.com:443/v0/b/swiftuichatapp-d2de3.appspot.com/o/chatImages%2FggmqrjQZWjhKagFgZpXCOT4MC7r1.jpg?alt=media&token=b2aca8f0-1f52-48e6-96a2-26f297e50eb4"), uid: "")
    }
}

struct chatModifier : ViewModifier{
    var myMessage : Bool
    func body(content: Content) -> some View {
        content
            .padding(.all, 10)
            .background(myMessage ? Color.teal : Color.gray)
            .cornerRadius(10)
            .foregroundColor(Color.white)
    }
}
