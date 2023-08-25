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

struct CustomChatBackNUserButton: View {
    var chatUser: AuthUserData?
    let userProfileButtonAction: () -> Void

    var body: some View {
        HStack(spacing: 10){
            Button {
                NavigationUtil.popToRootView()
            } label: {
                Image(systemName: "chevron.backward").font(.title2)
            }
            Button {
                userProfileButtonAction()
            } label: {
                CustomSDWebImageView(imgURL: URL(string: chatUser?.profilePic ?? "")!, imgWidth: 40, imgHeight: 40, placeholderImage: StringConstants.placeholderImagePerson, isCircle: true)
            }
            VStack(alignment: .leading){
                Text(chatUser?.name ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
//                Text(strName ?? "")
//                    .font(.caption)
//                    .foregroundColor(.primary)
            }
        }
    }
}

//struct CustomChatBackNUserButton_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomChatBackNUserButton(imgUrl: .constant(URL(string: "https://firebasestorage.googleapis.com:443/v0/b/swiftuichatapp-d2de3.appspot.com/o/images%2F9xfYIgiQSSWb6E3hXeVuAmyfbJG2.jpg?alt=media&token=48e39b64-522b-4877-84b9-29ab63a8229a")!), strName: .constant("Rahul"), strLastSeen: .constant("Today"))
//    }
//}
