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
    
    @State private var authViewModel : AuthViewModel
    
    init() {
        
        FirebaseApp.configure()
        
        let sessionManager = SessionManager()
        _sessionManager = StateObject(wrappedValue: sessionManager)
        
        let viewModel = AppDiContainer.shared.makeAuthViewModel(sessionManager: sessionManager)
        _authViewModel = State(initialValue: viewModel)
    }

      var body: some Scene {
        WindowGroup {
          NavigationView {
              RootView(authViewModel: authViewModel)
                  .environmentObject(sessionManager)
          }
        }
      }
}
