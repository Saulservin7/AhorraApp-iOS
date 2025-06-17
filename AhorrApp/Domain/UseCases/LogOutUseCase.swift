//
//  LogOutUseCase.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/28/25.
//
struct LogOutUseCase{
    let repository : AuthRepository
    
    func execute() -> Result<Void,AppError>{
        do{
            try repository.logout()
            return .success(())
        } catch let appError as AppError{
            return .failure(appError)
        } catch {
            return .failure(.unknown)
        }
    }
}

