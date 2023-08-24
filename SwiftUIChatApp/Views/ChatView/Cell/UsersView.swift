//
//  UsersView.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 17/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct UsersView: View {
    var usersData : AuthUserData
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                let imgUrl = URL(string: usersData.profilePic ?? "")
                CustomSDWebImageView(imgURL: imgUrl, imgWidth: 50, imgHeight: 50, placeholderImage: StringConstants.placeholderImagePerson, isCircle: true)
                    .padding(.trailing, 10)
                VStack(alignment: .leading, spacing: 0, content: {
                    Text("\(usersData.name ?? "")").font(.headline).foregroundColor(.black)
                    Text("\(usersData.countryCode ?? "") \(usersData.mobile ?? "")").font(.caption).foregroundColor(.gray)
                })
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//        .background(.white)
//        .cornerRadius(10)
//        .shadow(radius: 5)
//        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView(usersData: AuthUserData(profilePic: "", name:  "Rahul", email: "rp@mailinator.com", dob: "", gender: "", countryCode: "+91", mobile: "9999889988", userId: ""))
    }
}
