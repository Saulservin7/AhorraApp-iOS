//
//  HomeView.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/28/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var sessionManager: SessionManager
    @State private var isShowingProfile = false
    @ObservedObject var authViewmodel : AuthViewModel
    private let diContainer = AppDiContainer.shared
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0){
                HStack(alignment: .center){
                    Text("Home").font(.largeTitle).fontWeight(.bold)
                    Spacer()
                    
                    HStack(spacing: 20){
                        
                        Button(action:{
                            authViewmodel.logout()
                        }){
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundStyle(.primary)
                        }
                        Button(action:{
                            self.isShowingProfile = true
                        }){
                            if let user = authViewmodel.user, let photoURL = user.photoURL{
                                ProfileBubble(imageURL: photoURL)
                            }}
                        
                    }
                    
                }.padding([.horizontal,.top],40)
            }
            ZStack(alignment: .bottomTrailing) {
                // --- MODIFICACIÓN #1 ---
                // Se añade un .padding(.top) a la VStack para crear
                // un espacio entre el título y el contenido.
                VStack {
                    // El contenido principal de tu vista no cambia
                    HStack {
                        Spacer()
                    }
                    .padding([.horizontal, .trailing], 40)
                    
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible())]) {
                            ForEach(0..<10) { _ in
                                RoomCard()
                                    .padding(.bottom, 16)
                            }
                        }
                        .padding([.horizontal, .trailing], 20)
                    }
                }
                .padding(.top) // <--- PADDING SUPERIOR AÑADIDO AQUÍ
                
                FloatingButton(title: "+", action: {})
                    .padding(.trailing, 40)
                    .padding(.bottom, 20)
            }
            
        }
        .sheet(isPresented: $isShowingProfile, onDismiss: {
            Task {
                await authViewmodel.fetchCurrentUser()
            }
        }) {
            if #available(iOS 17.0, *) {
                ProfileView(viewModel: diContainer.makeProfileViewModel())
            }
        }
    }
}


#Preview {
    
    let sessionManager = SessionManager()
    let viewModel = AppDiContainer.shared.makeAuthViewModel(sessionManager: sessionManager)
    
    HomeView(authViewmodel: viewModel)
        .environmentObject(sessionManager)
    
}

