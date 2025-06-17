//
//  RootView.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/28/25.
//
import SwiftUI
struct RootView: View {
    @StateObject private var sessionManager = SessionManager()
    
    private let authViewModel = AppDiContainer.shared.makeAuthViewModel()
    
    var body: some View {
        Group {
            if sessionManager.isAuthenticated {
                HomeView()
                    .environmentObject(sessionManager)
            } else {
                LoginView(viewModel : authViewModel)
                    .environmentObject(sessionManager)
            }
        }
    }
}
