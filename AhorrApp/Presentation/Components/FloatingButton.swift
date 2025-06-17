//
//  FloatingButton.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/30/25.
//

import SwiftUI

struct FloatingButton: View {
    var title:String
    var action: ()-> Void
    var body: some View {
        Button(action: action){
            Text(title)
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(
                    Circle()
                        .fill(Color(hex: "F09999"))
                        .frame(width: 80, height: 80)
                )
                .shadow(radius: 10)
                
        }
    }
}


#Preview{
    
        FloatingButton(title: "+", action: {
            print("Floating button tapped!")
        })
    
}
