//
//  UserRepositoryImpl.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

import FirebaseFirestore

final class UserRepositoryImpl: UserRepository{
    
    private let db = Firestore.firestore()
    
    func createUser(_ user: User) async throws {
        let data: [String: Any] = [
            "id":user.id,
            "email":user.email
            
        ]
        try await db.collection("users").document(user.id).setData(data)
    }
    
    
}
