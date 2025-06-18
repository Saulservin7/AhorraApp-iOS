//
//  LoginView.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/25/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject  var viewModel : AuthViewModel
    @State private var isLoading = false  // Variable para manejar el estado de carga
    @State private var path: [AppRoute] = []
    @EnvironmentObject private var sessionManager: SessionManager

    var body: some View {
        NavigationStack(path: $path){
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: "3a8d6d"),
                        Color(hex: "3a8d6d").opacity(0.7)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    Text("AhorrApp")
                        .font(.largeTitle)
                        .padding(.bottom, 40)
                        .foregroundColor(Color.white)
                    
                    Image("Icon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .padding(.bottom, 20)
                    
                    LoginTextField(placeholder: "Email", text: $viewModel.email, isSecure: false)
                    LoginTextField(placeholder: "Password", text: $viewModel.password, isSecure: true)
                    
                    // Botón de login
                    StandarButton(title: "Iniciar Sesión", isPrimary: true) {
                        Task {
                            isLoading = true  // Inicia el loading
                            await viewModel.login()
                            isLoading = false  // Detiene el loading después de la acción
                        }
                    }
                    
                    // Botón de registro
                    StandarButton(title: "Registrarse", isPrimary: false) {
                        Task {
                            isLoading = true
                            await viewModel.register()
                            isLoading = false
                        }
                    }
                    
                    // Mostrar indicador de carga si es necesario
                    if isLoading {
                        ProgressView()  // Un simple indicador de carga
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding()
                    }
                    
                    // Mostrar mensaje de error
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding(.top, 10)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding(20)
                
            }.navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .home:
                    HomeView(authViewmodel: viewModel)
                        .environmentObject(sessionManager) // ✅ Pasa también el SessionManager
                default:
                    EmptyView()
                }
            }
            .onChange(of: viewModel.appRoute) { newRoute in
                if let newRoute = newRoute {
                    path.append(newRoute)
                }
            }
            .onChange(of: viewModel.isLoginSuccess) { isSuccess in
                if isSuccess {
                    sessionManager.signIn()  // ✅ Marcas sesión activa
                }
            }
        }
    }
}




