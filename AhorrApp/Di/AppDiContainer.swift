//
//  AppDiContainer.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/25/25.
//
import FirebaseFirestore

final class AppDiContainer{
    @MainActor static let shared=AppDiContainer()
    private let firestoreService = Firestore.firestore()
    
    private init(){}
    
    @MainActor
    func makeAuthViewModel(sessionManager:SessionManager) -> AuthViewModel {
        let repository=FirebaseAuthService()
        let userRepository = UserRepositoryImpl()
        let loginUseCase = LoginUseCase(repository: repository)
        let registerUseCase=RegisterUseCase(repository: repository)
        let logOutUseCase = LogOutUseCase(repository: repository)
        let createUserUseCase = CreateUserUseCase(repository: userRepository)
        return AuthViewModel(loginUseCase: loginUseCase, registerUseCase: registerUseCase,logOutUseCase: logOutUseCase,createUserUseCase:createUserUseCase, sessionManager: sessionManager)
        
        
    }
    
    @available(iOS 17.0, *)
    @MainActor
    
    func makeProfileViewModel() -> ProfileViewModel {
        
        let userRepository = UserRepositoryImpl()
        let getUserUseCase = GetUserUseCase(repository: userRepository)
        
        let firebaseCurrentUserProvider = FirebaseCurrentUserProvider()
        let getCurrentUserIdUseCase = GetCurrentUserIdUseCase(currentUserProvider: firebaseCurrentUserProvider)
        
        let updateUserProfileUseCase = UpdateUserProfileUseCase(userRepository: userRepository)
        
        let profileViewModel = ProfileViewModel(getUserUseCase: getUserUseCase, updateUserProfileUseCase: updateUserProfileUseCase, getCurrentUserIdUseCase: getCurrentUserIdUseCase)
        
        return profileViewModel
    }
    
    @MainActor func makeSalaViewModel() -> RoomViewModel {
        let repo = RoomRepositoryImpl(db: firestoreService)
        return RoomViewModel(
            createRoomUseCase: CreateSalaUseCase(repository: repo),
        )
    }
}

