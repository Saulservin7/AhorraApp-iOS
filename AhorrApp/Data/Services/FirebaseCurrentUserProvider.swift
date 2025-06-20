//
//  FirebaseCurrentUserProvider.swift
//  AhorrApp
//
//  Created by Saul Servin on 19/06/25.
//

import FirebaseAuth

final class FirebaseCurrentUserProvider: CurrentUserProvider{
    func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
}
