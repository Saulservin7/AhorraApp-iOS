//
//  ProfileBubble.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/30/25.
//

import SwiftUI

struct ProfileBubble: View {
    var imageURL: URL
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView() // mientras carga
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            case .failure:
                Image(systemName: "person.crop.circle.badge.exclam")
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 60, height: 60)
    
    }
}


#Preview {
    ProfileBubble(imageURL: URL(string: "https://assets.laliga.com/squad/2024/t186/p220160/2048x2048/p220160_t186_2024_1_002_000.jpg")!)
}

