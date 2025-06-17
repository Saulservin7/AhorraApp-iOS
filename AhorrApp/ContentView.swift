//
//  ContentView.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/25/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
     var body: some View {
        Text("Verificando Firebase...")
            .onAppear {
                Auth.auth().createUser(withEmail: "test@firebase.com", password: "123456") { result, error in
                    if let error = error {
                        print("❌ Firebase conexión fallida: \(error.localizedDescription)")
                    } else {
                        print("✅ Firebase conectado correctamente")
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}
