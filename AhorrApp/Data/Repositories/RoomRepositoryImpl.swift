//
//  RoomRepositoryImpl.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

import FirebaseFirestore
final class RoomRepositoryImpl:RoomRepository{
    
    private let db = Firestore.firestore()
    
    func createRoom(_ room: Room) async throws {
        try db.collection("rooms").document(room.id).setData(from: room)
    }
    
    func getSala(byJoinCode code: String) async throws -> Room {
        let snapshot = try await db.collection("rooms")
            .whereField("joinCode", isEqualTo: code)
            .getDocuments()
        
        guard let doc = snapshot.documents.first else{
            throw AppError.authenticationError("Sala no encontrada")
        }
        return try doc.data(as: Room.self)
    }
    
    func addUser(to salaId: String, userId: String) async throws {
        let ref = db.collection("rooms").document(salaId)
        try await ref.updateData([
            "usuarios":FieldValue.arrayUnion([userId])
        ])
    }
    
    func updateGameData(salaId: String, gameData: GameData) async throws {
        let ref = db.collection("rooms").document(salaId)
        try await ref.updateData([
            "juego.data": try Firestore.Encoder().encode(gameData)
        ])
    }
    
    func observeSala(id: String) -> AsyncStream<Room> {
            let ref = db.collection("rooms").document(id)
            return AsyncStream { continuation in
                let listener = ref.addSnapshotListener { snapshot, error in
                    if let snapshot, let data = try? snapshot.data(as: Room.self) {
                        continuation.yield(data)
                    }
                }
                continuation.onTermination = { _ in listener.remove() }
            }
        }
    
    
}
