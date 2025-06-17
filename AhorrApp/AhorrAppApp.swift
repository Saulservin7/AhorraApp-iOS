//
//  AhorrAppApp.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/25/25.
//

import SwiftUI
import Firebase

@main
struct AhorrAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var sessionManager = SessionManager()

      var body: some Scene {
        WindowGroup {
          NavigationView {
            RootView()
                  .environmentObject(sessionManager)
          }
        }
      }
}
