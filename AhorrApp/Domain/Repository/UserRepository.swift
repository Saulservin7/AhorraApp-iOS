//
//  UserRepository.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

import Foundation
protocol UserRepository{
    func createUser(_ user:User) async throws
    
    func getUser(id:String) async throws -> User
    
    func updateUserProfile (id:String,name:String?,photoURL : URL?) async throws
    
    func uploadProfileImage(data:Data,userId:String, fileName: String) async throws -> URL
}

