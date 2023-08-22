//
//  SwiftUIChatAppApp.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 11/08/23.
//

import SwiftUI
import FirebaseCore
import Firebase

@main
struct SwiftUIChatAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            SplashView().environmentObject(SessionManager.shared)
        }
    }
}
