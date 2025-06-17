//
//  RoomCard.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/30/25.
//

import SwiftUI

struct RoomCard:View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(hex: "5DB68D"))
            .shadow(radius: 4)
            .overlay(
                HStack {
                    VStack(alignment: .leading,spacing: 4) {
                        Text("Ruleta")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("Participantes:")
                            .font(.title3)
                            .foregroundColor(.white)
                        Text("Rango:")
                            .font(.title3)
                            .foregroundColor(.white)
                        Text("Ahorro Total:")
                            .font(.title3)
                            .foregroundColor(.white)
                    }.padding(.vertical)

                    Spacer()

                    VStack {
                        Image("roulette_Icon")
                            .resizable()
                            .scaledToFit()
                    }
                }.padding()
            )
            .frame(height: 140)
            .padding(.horizontal)
    }
}


#Preview {
    RoomCard()
}
