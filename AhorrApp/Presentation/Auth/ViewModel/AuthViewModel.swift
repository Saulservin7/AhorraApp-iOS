//
//  AuthViewModel.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/25/25.
//

import Foundation
import FirebaseAuth

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var appRoute: AppRoute?
    @Published var isLoginSuccess: Bool = false
    @Published var user: User? = nil

    private let loginUseCase: LoginUseCase
    private let registerUseCase: RegisterUseCase
    private let logOutUseCase: LogOutUseCase
    private let createUserUseCase: CreateUserUseCase
    private let getUserUseCase : GetUserUseCase
    private let getCurrentUserIdUseCase : GetCurrentUserIdUseCase
    
    private weak var sessionManager:SessionManager?

    init(
        loginUseCase: LoginUseCase,
        registerUseCase: RegisterUseCase,
        logOutUseCase: LogOutUseCase,
        createUserUseCase:CreateUserUseCase,
        sessionManager : SessionManager,
        getCurrentUserIdUseCase : GetCurrentUserIdUseCase,
        getCurrentUser : GetUserUseCase
    ) {
        self.loginUseCase = loginUseCase
        self.registerUseCase = registerUseCase
        self.logOutUseCase = logOutUseCase
        self.createUserUseCase = createUserUseCase
        self.sessionManager = sessionManager
        self.getCurrentUserIdUseCase = getCurrentUserIdUseCase
        getUserUseCase = getCurrentUser
        
        if sessionManager.isAuthenticated {
            if let userId = Auth.auth().currentUser?.uid {
                Task {
                    await fetchUser(userId: userId)
                }
            }
        }
    }

    func login() async {
        let result = await loginUseCase.execute(email: email, password: password)
        switch result {
        case .success:
            appRoute = .home
            isLoginSuccess = true
            sessionManager?.signIn()
            
            if let userId = Auth.auth().currentUser?.uid{
                await fetchUser(userId: userId)
            }
            
            break
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }

    func register() async {
        let result = await registerUseCase.execute(email: email, password: password)
        switch result {
        case .success:
            guard let user = Auth.auth().currentUser else { return }
                       let _ = await createUserUseCase.execute(id: user.uid, email: user.email ?? "")
            appRoute = .home
            isLoginSuccess = true
            sessionManager?.signIn()
            break
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }
    
    func logout() {
        let result = logOutUseCase.execute()
        
        switch result {
        case .success:
            appRoute = nil   // ✅ Limpias la ruta
            isLoginSuccess = false  // ✅ Ya no hay sesión activa
            sessionManager?.signOut()
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }
    
    
    func fetchUser(userId:String)async{
        
        let result = await getUserUseCase.execute(id: userId)
        
        switch result{
        case .success(let user):
            self.user = user
            
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    func fetchCurrentUser() async {
        if let userId =  Auth.auth().currentUser?.uid {
            let result = await getUserUseCase.execute(id: userId)
            switch result {
            case .success(let user):
                self.user = user    // Esto actualiza la UI
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

