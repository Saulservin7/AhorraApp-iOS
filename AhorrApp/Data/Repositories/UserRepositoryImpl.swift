//
//  UserRepositoryImpl.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

import FirebaseFirestore
import Foundation
import FirebaseStorage

final class UserRepositoryImpl: UserRepository{
    
    private let db : Firestore
    private let storage : Storage
    
    init(db: Firestore = Firestore.firestore(),storage:Storage = Storage.storage() ) {
        self.db = db
        self.storage = storage
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
    
    
    func uploadProfileImage(data: Data, userId: String, fileName: String) async throws -> URL {
        let storageRef = storage.reference().child("profile_images/\(userId)/\(fileName)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        _ = try await storageRef.putDataAsync(data, metadata: metadata)
        let downloadURL = try await storageRef.downloadURL()
        return downloadURL
    }
    
    func updateUserProfile(id: String, name: String?, photoURL: URL?) async throws {
        
        var updates: [String: Any] = [:]
        
        if let name = name{
            updates["name"] = name
        }
        
        if let photoURL = photoURL{
            updates["photoURL"] = photoURL.absoluteString
        }
        
        guard !updates.isEmpty else{
            print("No hay campos para actualizar")
            return
        }
        
        do{
            try await db.collection("users").document(id).updateData(updates)
        } catch let error as NSError{
            if error.code == FirestoreErrorCode.notFound.rawValue{
                throw AppError.authenticationError("Usuario no encontrado para actualizar ")
            } else{
                throw AppError.unknown
            }
        } catch{
            throw AppError.unknown
        }
        
    }
    
    
}
