//
//  GetUserUseCase.swift
//  AhorrApp
//
//  Created by Saul Servin on 17/06/25.
//

struct GetUserUseCase{
    
    private let repository : UserRepository
    
    init(repository : UserRepository) {
        self.repository = repository
    }
    
    func execute (id:String) async -> Result<User,AppError>{
        do{
            let user = try await repository.getUser(id: id)
            return .success(user)
        } catch let error as AppError{
            return .failure(error)
        }catch{
            return .failure(.unknown)
        }
        
    }
}
