//
//  HomeView.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/28/25.
//

import SwiftUI

struct HomeView: View {
    //@EnvironmentObject private var sessionManager: SessionManager
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                HStack {
                    Text("Home")
                        .font(.title)

                    Spacer()

                    ProfileBubble(imageURL: URL(string: "https://assets.laliga.com/squad/2024/t186/p220160/2048x2048/p220160_t186_2024_1_002_000.jpg")!)
                }
                .padding([.horizontal, .trailing], 40)

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        ForEach(0..<10) { _ in
                            RoomCard()
                                .padding(.bottom, 16)
                        }
                    }
                    .padding([.horizontal, .trailing], 20)
                }
            }

            FloatingButton(title: "+", action: {})
                .padding(.trailing, 40)
                .padding(.bottom, 20)
        }
    }
}


#Preview {
    HomeView()
}
