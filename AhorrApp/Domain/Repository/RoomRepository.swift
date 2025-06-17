//
//  RoomRepository.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

protocol RoomRepository{
    func createRoom(_ room:Room)async throws
    func getSala(byJoinCode code:String)async throws->Room
    func addUser(to salaId:String,userId:String)async throws
    func updateGameData(salaId:String,gameData:GameData)async throws
    func observeSala(id:String) -> AsyncStream<Room>
}
