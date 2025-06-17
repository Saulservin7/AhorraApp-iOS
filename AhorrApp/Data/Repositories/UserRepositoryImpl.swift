//
//  UserRepositoryImpl.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

import FirebaseFirestore

final class UserRepositoryImpl: UserRepository{
    
    private let db : Firestore
    
    init(db: Firestore = Firestore.firestore() ) {
        self.db = db
    }
    
    func createUser(_ user: User) async throws {
        let data: [String: Any] = [
            "id":user.id,
            "email":user.email
            
        ]
        try await db.collection("users").document(user.id).setData(data)
    }
    
    func getUser(id: String) async throws -> User {
        
        let documentSnapshot = try await db.collection("users").document(id).getDocument()
        
        guard let user = try? documentSnapshot.data(as: User.self) else{
            throw AppError.authenticationError("Usuario no encontrado")
        }
        
        return user
    }
    
    
}
