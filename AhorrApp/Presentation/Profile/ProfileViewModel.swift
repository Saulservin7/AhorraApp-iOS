//
//  ProfileViewModel.swift
//  AhorrApp
//
//  Created by Saul Servin on 17/06/25.
//
import Foundation
import FirebaseAuth

@MainActor
final class ProfileViewModel : ObservableObject {
    
    enum ViewState {
        case loading
        case success(user:User)
        case error (message:String)
    }
    
    @Published var state: ViewState = .loading
    
    private let getUserUseCase : GetUserUseCase
    
    init(getUserUseCase: GetUserUseCase){
        self.getUserUseCase = getUserUseCase
        
    }
    
    
    func fetchCurrentUser() async {
        // Nos aseguramos de tener un ID de usuario.
        guard let userId = Auth.auth().currentUser?.uid else {
            self.state = .error(message: "No hay sesión de usuario activa.")
            return
        }
        
        // El estado ya es .loading por defecto, no hace falta cambiarlo.
        
        let result = await getUserUseCase.execute(id: userId)
        
        switch result{
        case .success(let user):
            self.state = .success(user: user)
        case .failure(let error):
            self.state = .error(message: error.localizedDescription)
        }
    }
}
