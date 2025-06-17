//
//  RootView.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/28/25.
//
import SwiftUI
struct RootView: View {
    @StateObject private var sessionManager = SessionManager()

    var body: some View {
        Group {
            if sessionManager.isAuthenticated {
                HomeView()
                    .environmentObject(sessionManager)
            } else {
                LoginView()
                    .environmentObject(sessionManager)
            }
        }
    }
}
