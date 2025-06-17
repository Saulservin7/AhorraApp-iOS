//
//  LoginButton.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/26/25.
//

import SwiftUI

struct StandarButton: View {
    let title: String
    let isPrimary: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(isPrimary ? .white : .white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isPrimary ? Color(hex: "f4a4a4") : Color.clear)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: isPrimary ? 0 : 2)
                )
        }
        .padding(.horizontal)
    }
}
