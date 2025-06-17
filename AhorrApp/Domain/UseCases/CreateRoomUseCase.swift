//
//  CreateRoomUseCase.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

struct CreateSalaUseCase {
    let repository: RoomRepository

    func execute(room: Room) async -> Result<Void, AppError> {
        do {
            try await repository.createRoom(room)
            return .success(())
        } catch let error as AppError {
            return .failure(error)
        } catch {
            return .failure(.unknown)
        }
    }
}
