//
//  User.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/29/25.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: String
    let email: String
    let name: String?
    let photoURL: URL?
}
