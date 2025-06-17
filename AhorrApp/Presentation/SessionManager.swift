//
//  SessionManager.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/28/25.
//
import Foundation
import FirebaseAuth
@MainActor
final class SessionManager: ObservableObject {
    @Published var isAuthenticated: Bool = false

    init() {
        self.isAuthenticated = checkSession()
    }
    
    private func checkSession() -> Bool {
        // Aquí puedes usar FirebaseAuth o UserDefaults para checar
        return Auth.auth().currentUser != nil
    }

    func signIn() {
        isAuthenticated = true
    }

    func signOut() {
        try? Auth.auth().signOut()
        isAuthenticated = false
    }
}
