//
//  SwiftUIChatAppApp.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 24/08/23.
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
