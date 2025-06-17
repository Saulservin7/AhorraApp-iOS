//
//  RegisterUseCase.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/25/25.
//

struct RegisterUseCase {
    let repository: AuthRepository
    
    func execute(email: String, password: String) async -> Result<Void, AppError> {
        do {
            try await repository.register(email: email, password: password)
            return .success(())
        } catch let appError as AppError {
            return .failure(appError)
        } catch {
            return .failure(.unknown)
        }
    }
}
