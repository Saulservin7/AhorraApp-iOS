//
//  AuthRepository.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/25/25.
//

protocol AuthRepository {
    func login(email: String, password: String) async throws 
    func register(email: String, password: String) async throws
    func logout() throws
}
