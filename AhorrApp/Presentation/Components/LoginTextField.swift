//
//  LoginTextField.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/26/25.
//

import SwiftUI

struct LoginTextField: View {
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        
        .padding(.horizontal)
    }
}
