//
//  RootView.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/28/25.
//
import SwiftUI
struct RootView: View {
    @ObservedObject  var authViewModel : AuthViewModel
    @EnvironmentObject private var sessionManager : SessionManager
    
   
    
    var body: some View {
        Group {
            if sessionManager.isAuthenticated {
                HomeView(authViewmodel : authViewModel)
                    
            } else {
                LoginView(viewModel : authViewModel)
                   
            }
        }
    }
}
