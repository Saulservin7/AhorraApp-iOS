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
            // --- MODIFICACIÓN #2 ---
            // Se restaura el modificador .navigationTitle(). Esta es la forma
            // correcta en SwiftUI de mostrar un título grande a la izquierda.
            .navigationTitle("Home")
            .toolbar{
                // Mantenemos el ToolbarItemGroup solo para los botones de la derecha.
                ToolbarItemGroup(placement : .navigationBarTrailing){
                    
                    // Botón para mostrar el perfil
                    Button(action:{
                        self.isShowingProfile = true
                    }){
                        ProfileBubble(imageURL: URL(string: "https://assets.laliga.com/squad/2024/t186/p220160/2048x2048/p220160_t186_2024_1_002_000.jpg")!)
                    }
                    
                    // Botón para cerrar sesión
                    Button(action:{
                        authViewmodel.logout()
                    }){
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingProfile){
            ProfileView(viewModel: diContainer.makeProfileViewModel())
        }
    }
}
