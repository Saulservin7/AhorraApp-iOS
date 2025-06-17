//
//  RouletteView.swift
//  AhorrApp
//
//  Created by Saúl  Servín  on 4/28/25.
//

import SwiftUI

struct RouletteView: View {
    @State private var number = 0
        @State private var isSpinning = false
        @State private var range: ClosedRange<Int> = 1...365

        var body: some View {
            VStack(spacing: 40) {
                Text(isSpinning ? "Girando..." : "Resultado: \(number)")
                    .font(.system(size: 40, weight: .bold))
                    .padding()

                Button("🎯 Girar Ruleta") {
                    spin()
                }
                .disabled(isSpinning)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }

        func spin() {
            isSpinning = true
            var spins = 0
            let totalSpins = Int.random(in: 30...60)
            let timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
                number = Int.random(in: range)
                spins += 1
                if spins >= totalSpins {
                    timer.invalidate()
                    number = Int.random(in: range) // número final
                    isSpinning = false
                }
            }
            RunLoop.main.add(timer, forMode: .common)
        }
}

#Preview {
    RouletteView()
}
