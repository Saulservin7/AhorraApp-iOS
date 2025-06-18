//
//  ProfileView.swift
//  AhorrApp
//
//  Created by Saul Servin on 17/06/25.
//

import SwiftUI

struct ProfileView : View{
    
    @StateObject var viewModel : ProfileViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack(spacing : 20){
                switch viewModel.state {
                case .loading:
                    ProgressView("Cargando Perfil")
                case .success(let user):
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    Text(user.email)
                        .font(.title2)
                        .fontWeight(.semibold)
                case .error(let message):
                    Image(systemName: "exclamationmark.triangle.fill")
                                           .font(.system(size: 50))
                                           .foregroundColor(.red)
                                       Text(message)
                                           .foregroundColor(.red)
                                           .multilineTextAlignment(.center)
                                           .padding()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Perfil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                                    Button("Cerrar") {
                                        dismiss() // Llama a la acción de SwiftUI para cerrar la vista.
                                    }
                                }
            }
        }
        .onAppear{
            Task{
                await viewModel.fetchCurrentUser()
            }
        }
    }
    
}

#Preview("Vista Real") {
    // 1. Obtenemos el contenedor de dependencias.
    let diContainer = AppDiContainer.shared
    
    // 2. Creamos una instancia real del ViewModel.
    //    NOTA: Para que esto funcione, necesitarás crear la función
    //    'makeProfileViewModel' en tu DIContainer si no lo has hecho ya.
    let realViewModel = diContainer.makeProfileViewModel()
    
    // 3. Inyectamos el ViewModel en la vista para la preview.
    return ProfileView(viewModel: realViewModel)
}
