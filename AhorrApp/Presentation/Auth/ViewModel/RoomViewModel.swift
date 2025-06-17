//
//  RoomViewModel.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//
import Foundation

@MainActor
final class RoomViewModel: ObservableObject{
    
    @Published var room:Room?
    @Published var errorMessage:String?
    
    private let createRoomUseCase: CreateSalaUseCase
    
    init(createRoomUseCase: CreateSalaUseCase) {
        self.createRoomUseCase = createRoomUseCase
    }
    
    
    func createRoom(nombre:String,usuario:String,juego:Game) async{
        let room=Room(
            id: UUID().uuidString, joinCode: String(Int.random(in: 1000...9999)), nombre: nombre, usuarios: [usuario], juego: juego, totalSave: 0.0
        )
        let result = await createRoomUseCase.execute(room: room)
        
        if case .success = result {
            self.room = room
        }else if case .failure (let error) = result {
            self.errorMessage = error.localizedDescription
        }
        
    }
    
}
