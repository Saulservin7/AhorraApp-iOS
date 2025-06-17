//
//  CreateUserUseCase.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

struct CreateUserUseCase{
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(id:String,email:String) async -> Result<Void,AppError>{
        let user = User(id: id, email: email)
        do{
            try await repository.createUser(user)
            return .success(())
            
        }catch let error as AppError{
            return .failure(error)
        }catch{
            return .failure(.unknown)
        }
    }
}
