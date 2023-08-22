//
//  ChatListRow.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 22/08/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatListRow: View {
    var msgData : ChatListModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                let imgUrl = URL(string: msgData.userProfilePic ?? "")
                CustomSDWebImageView(imgURL: imgUrl, imgWidth: 50, imgHeight: 50, placeholderImage: StringConstants.placeholderImagePerson, isCircle: true)
                
                VStack(alignment: .leading, spacing: 0, content: {
                    Text("\(msgData.userName ?? "")").font(.headline)
                    
                    switch msgData.msgType {
                    case .text:
                        Text("\(msgData.lastMessage ?? "")")
                            .font(.caption)
                            .foregroundColor(.black)
                            .lineLimit(1)
                    case .some(.picture):
                        HStack {
                            Image(systemName: StringConstants.placeholderImagePicture)
                                .foregroundColor(.gray)
                            Text(msgData.msgType!.rawValue.capitalized).font(.caption)
                                .foregroundColor(.gray)
                        }
                    case .some(.video):
                        HStack {
                            Image(systemName: StringConstants.placeholderImageVideo)
                                .foregroundColor(.gray)
                            Text(msgData.msgType!.rawValue.capitalized).font(.caption)
                                .foregroundColor(.gray)
                        }
                    case .some(.location):
                        HStack {
                            Image(systemName: StringConstants.placeholderImageLocation)
                                .foregroundColor(.gray)
                            Text(msgData.msgType!.rawValue.capitalized).font(.caption)
                                .foregroundColor(.gray)
                        }
                    case .none:
                        Text("\(msgData.lastMessage ?? "")").font(.caption)
                    }
                })
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

struct ChatListRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatListRow(msgData: ChatListModel(userName: "R P", userProfilePic: "https://firebasestorage.googleapis.com:443/v0/b/swiftuichatapp-d2de3.appspot.com/o/images%2F9xfYIgiQSSWb6E3hXeVuAmyfbJG2.jpg?alt=media&token=48e39b64-522b-4877-84b9-29ab63a8229a", lastMessage: "wqeqweqw", msgType: .video))
    }
}
