//
//  AppError.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/27/25.
//
import Foundation

enum AppError:Error,LocalizedError{
    
    case networkError
    case authenticationError(String)
    case invalidCredentials
    case unknown
    
    
    var errorDescription: String? {
        switch self{
        case.networkError:
            return "Problema de Conexión, verifica tu conexión a internet"
        case.authenticationError(let message):
            return message
        
        case.invalidCredentials:
            return "Usuario o Contraseña Incorrectos"
        case.unknown:
            
            return "Error. Vuelva a Intentarlo"
            
        }
        
    }

    
}


enum AuthError:Error{
    case invalidEmail
    case invalidPassword
    case userNotFound
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidEmail:
            return "Email inválido"
        case .invalidPassword:
            return "Contraseña inválida"
        case .userNotFound:
            return "Usuario no encontrado"
        case .unknown:
            return "Error "
        }
    }
}
