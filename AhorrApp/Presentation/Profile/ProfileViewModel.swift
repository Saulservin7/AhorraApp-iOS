//
//  ProfileViewModel.swift
//  AhorrApp
//
//  Created by Saul Servin on 17/06/25.
//
import Foundation
import SwiftUI

@available(iOS 17.0, *)
@Observable
final class ProfileViewModel : ObservableObject {
    
    enum ViewState: Equatable{
        case loading
        case success(user:User)
        case error (message:String)
    }
    
    
    private let getUserUseCase: GetUserUseCase
    private let updateUserProfileUseCase : UpdateUserProfileUseCase
    private let getCurrentUserIdUseCase : GetCurrentUserIdUseCase
    
    init(getUserUseCase: GetUserUseCase,
             updateUserProfileUseCase: UpdateUserProfileUseCase,
             getCurrentUserIdUseCase: GetCurrentUserIdUseCase) {
            self.getUserUseCase = getUserUseCase
            self.updateUserProfileUseCase = updateUserProfileUseCase
            self.getCurrentUserIdUseCase = getCurrentUserIdUseCase
        }
    
    var state:ViewState = .loading
    
    var currentUserName: String = ""
    
    var profileImage : UIImage?
    
    var showImagePicker = false
    
    var imageDataToUpload : Data?
    
    func fetchCurrentUser() async{
        state = .loading
        guard let userId = getCurrentUserIdUseCase.execute()else{
            state = .error(message: "No hay sesion de usuario activa ")
            return
        }
        
        let result = await getUserUseCase.execute(id: userId)
        
        switch result{
        case .success(let user):
            state = .success(user: user)
            currentUserName = user.name ?? ""
            
        case .failure(let error):
            state = .error(message: error.errorDescription ?? "Error desconocido")
            
        }
            
    }
    
    func updateProfile() async {
        guard case .success(let currentUser) = state else {
                    state = .error(message: "No se pudo obtener el usuario para actualizar.")
                    return
                }
                
                // Solo actualizar si el nombre o la imagen han cambiado o hay una imagen nueva para subir
                let nameHasChanged = currentUserName != (currentUser.name ?? "")
                let imageHasChanged = imageDataToUpload != nil
                
                guard nameHasChanged || imageHasChanged else {
                    // No hay cambios, no hace falta actualizar
                    state = .success(user: currentUser) // Mantener el estado actual
                    return
                }
                
                state = .loading // Indicar que estamos realizando una operación
                
                guard let userId = getCurrentUserIdUseCase.execute() else {
                    state = .error(message: "No hay sesión de usuario activa para actualizar.")
                    return
                }
                
                do {
                    // Llama al Use Case para actualizar el perfil
                    try await updateUserProfileUseCase.execute(userId: userId, name: currentUserName, imageData: imageDataToUpload)
                    
                    // Si la actualización es exitosa, volvemos a cargar el usuario para reflejar los cambios
                    await fetchCurrentUser() // Vuelve a cargar el usuario para obtener los datos actualizados, incluyendo la nueva photoURL
                    
                    // Limpia los datos de la imagen después de una subida exitosa
                    imageDataToUpload = nil
                    profileImage = nil // Opcional: podrías mantener la imagen si la vista así lo requiere
                    
                } catch {
                    state = .error(message: "Error al actualizar perfil: \(error.localizedDescription)")
                }
        
    }
    
    func didSelectImage(_ uiImage: UIImage?) {
            guard let uiImage = uiImage else {
                imageDataToUpload = nil
                profileImage = nil
                return
            }
            
            profileImage = uiImage
            // Comprime la imagen a JPEG para reducir tamaño, puedes ajustar la calidad
            imageDataToUpload = uiImage.jpegData(compressionQuality: 0.8)
    }
    
}
    
    
