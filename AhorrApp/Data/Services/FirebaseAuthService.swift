//
//  FirebaseAuthService.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/25/25.
//

import FirebaseAuth


final class FirebaseAuthService: AuthRepository {
    func login(email: String, password: String) async throws {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch let error as NSError {
            throw mapFirebaseErrorToAppError(error)
        }
    }
    
    func register(email: String, password: String) async throws {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
        } catch let error as NSError {
            throw mapFirebaseErrorToAppError(error)
        }
    }
    
    func logout() throws {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            throw mapFirebaseErrorToAppError(error)
        }
    }

    
    private func mapFirebaseErrorToAppError(_ error: NSError) -> AppError {
        
        guard let code = AuthErrorCode(rawValue: error.code) else {
                return .unknown
            }
        switch code {
        case .userNotFound:
            return .authenticationError("El usuario no se encontró.")
        case .wrongPassword:
            return .authenticationError("La contraseña es incorrecta.")
        case .emailAlreadyInUse:
            return .authenticationError("El correo electrónico ya está en uso.")
        case .invalidEmail:
            return .authenticationError("El correo electrónico no es válido.")
        default:
            return .unknown
        }
    }
}
