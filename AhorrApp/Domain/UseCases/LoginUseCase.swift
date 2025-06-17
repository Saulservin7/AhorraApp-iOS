//
//  LoginUseCase.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/25/25.
//

struct LoginUseCase {
    let repository: AuthRepository

    func execute(email: String, password: String) async -> Result<Void, AppError> {
        do {
            try await repository.login(email: email, password: password)
            return .success(())
        } catch let error as AppError {
            return .failure(error)  // Ahora sí recibes el AppError directo
        } catch {
            return .failure(.unknown)
        }
    }
}
