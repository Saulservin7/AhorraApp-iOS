//
//  GetCurrentUserIdUseCase.swift
//  AhorrApp
//
//  Created by Saul Servin on 19/06/25.
//

protocol CurrentUserProvider{
    func getCurrentUserId()-> String?
}

struct GetCurrentUserIdUseCase{
    
    private let currentUserProvider : CurrentUserProvider
    
    init(currentUserProvider: CurrentUserProvider) {
        self.currentUserProvider = currentUserProvider
    }
    
    func execute() -> String?{
        return currentUserProvider.getCurrentUserId()
    }
}
