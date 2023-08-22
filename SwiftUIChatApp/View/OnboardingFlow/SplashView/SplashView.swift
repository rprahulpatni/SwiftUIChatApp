//
//  SplashView.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 05/06/23.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var sessionManager : SessionManager
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            if isPresented {
                if sessionManager.loggedUser != nil {
                    ContentView()
                } else {
                    OnboardingView()
                }
            } else {
                VStack{
                    Image(systemName: "ellipsis.message.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(10)
                        .foregroundColor(.teal)
                }.padding(.all, 10)
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation{
                    self.isPresented = true
                }
            }
        })
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
