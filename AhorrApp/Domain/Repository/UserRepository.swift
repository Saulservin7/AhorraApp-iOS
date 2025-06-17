//
//  UserRepository.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

protocol UserRepository{
    func createUser(_ user:User) async throws
    
    func getUser(id:String) async throws -> User
}

