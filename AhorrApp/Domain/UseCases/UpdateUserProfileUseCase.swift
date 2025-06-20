//
//  UpdateUserProfileUseCase.swift
//  AhorrApp
//
//  Created by Saul Servin on 19/06/25.
//

import Foundation

struct UpdateUserProfileUseCase{
    private let userRepository : UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute (userId:String,name:String?,imageData:Data?)async throws{
        var photoURL : URL? = nil
        
        if let imageData = imageData{
            let fileName = "\(userId)_\(UUID().uuidString).jpg"
            photoURL = try await userRepository.uploadProfileImage(data: imageData, userId: userId, fileName: fileName)
        }
        
        try await userRepository.updateUserProfile(id: userId, name: name, photoURL: photoURL)
    }
    
    
}
