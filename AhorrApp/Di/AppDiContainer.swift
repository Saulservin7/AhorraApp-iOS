//
//  AppDiContainer.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/25/25.
//

final class AppDiContainer{
    @MainActor static let shared=AppDiContainer()
    
    private init(){}
    
    @MainActor
    func makeAuthViewModel() -> AuthViewModel {
        let repository=FirebaseAuthService()
        let userRepository = UserRepositoryImpl()
        let loginUseCase = LoginUseCase(repository: repository)
        let registerUseCase=RegisterUseCase(repository: repository)
        let logOutUseCase = LogOutUseCase(repository: repository)
        let createUserUseCase = CreateUserUseCase(repository: userRepository)
        return AuthViewModel(loginUseCase: loginUseCase, registerUseCase: registerUseCase,logOutUseCase: logOutUseCase,createUserUseCase:createUserUseCase )
        
        
    }
    
    @MainActor func makeSalaViewModel() -> RoomViewModel {
        let repo = RoomRepositoryImpl()
        return RoomViewModel(
            createRoomUseCase: CreateSalaUseCase(repository: repo),
        )
    }
}



