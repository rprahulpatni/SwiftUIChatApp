//
//  CustomUserForm.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 17/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomUserForm: View {
    var user: AuthUserData?

    var body: some View {
        Form {
            if let user = user {
                Section{
                    HStack{
                        Spacer()
                        let imgUrl = URL(string: user.profilePic ?? "")
                        WebImage(url: imgUrl)
                            .resizable()
                            .placeholder(content: {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150, height: 150)
                            })
                            .indicator(.activity)
                            .clipShape(Circle())
                            .frame(width: 150, height: 150)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 5)
                            .padding()
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "person.circle")
                        Text(user.name ?? "")
                    }
                    HStack{
                        Image(systemName: "envelope")
                        Text(user.email ?? "")
                    }
                    HStack{
                        Image(systemName: "phone")
                        Text(user.countryCode ?? "")
                        Text(user.mobile ?? "")
                    }
                    HStack{
                        Image(systemName: "person.circle.fill")
                        Text(user.gender ?? "")
                    }
                    HStack{
                        Image(systemName: "calendar")
                        Text(user.dob ?? "")
                    }
                }
            } else {
                
            }
        }
    }
}

struct CustomUserForm_Previews: PreviewProvider {
    static var previews: some View {
        CustomUserForm(user: AuthUserData(profilePic: "", name:  "", email: "", dob: "", gender: "", countryCode: "", mobile: "", userId: ""))
    }
}
